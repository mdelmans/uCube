// ########################### Action ###########################
function Action( def, args ){
    this.def = def;
    this.args = args;
    this.self = {};
    this.exe = function(){
        return this.def.apply(self, this.args);
    }
}

function ActionConstructor( def ){
    this.def = def;
    this.new = function(){
        var args = Array.prototype.slice.call(arguments);
        var action = new Action(this.def, args);
        return action.exe();
    }
}

var newActionConstructor = function( def ){
    var action = new ActionConstructor(def);
    return action.new.bind(action);
}

// ########################### Operator ###########################

function Operator(def, args){
    this.def = def;
    this.args = args;
    
    this.exe = function(){
        return this.def.apply(this, this.args);
    }
    this.setChildren = function(){
        // this.children = arguments;
        this.children = Array.prototype.slice.call(arguments);
        return this.exe();
    }
}

function OperatorConstructor( def ){
    this.def = def;
    this.new = function(){
        var args = Array.prototype.slice.call(arguments);
        var operator = new Operator(this.def, args);
        return operator.setChildren.bind(operator);
    }
    this.newModule = function(){
        var args = Array.prototype.slice.call(arguments);
        var operator = new Operator(this.def, args);
        return operator.exe();
    }
}

var newOperatorConstructor = function( def ){
    var operator = new OperatorConstructor(def);
    return operator.new.bind(operator);
}

var newModuleConstructor = function( def ){
    var operator = new OperatorConstructor(def);
    return operator.newModule.bind(operator);
}

function numOrArray(size, mod=1){
    var ret = null;
    if (size instanceof Array){
        ret = size.map( x => mod*x );
    }
    
    else{
        ret = [size*mod, size*mod, size*mod];
    }
    return ret;
}

var cube = newActionConstructor( function(size=[1,1,1], isCenter = false) {
    var radius = numOrArray(size, 0.5);
    var center = isCenter ? [0, 0, 0] : radius;
    
    return CSG.cube({ center : center, radius : radius});
});

var cylinder = newActionConstructor( function(h=1, r1=1, r2=1, isCenter=false){
    var start = isCenter ? [0, 0, -0.5*h] : [0, 0, 0];
    var end = isCenter ? [0, 0, 0.5*h] : [0, 0, h];

    return CSG.cylinder({ start: start, end: end, radiusStart: r1, radiusEnd: r2 });    
});

var union = newOperatorConstructor( function(){
    return this.children.reduce( (u,c) => u.union(c) );
});

var difference = newOperatorConstructor(function(){
    return this.children.reduce( (u,c) => u.subtract(c) );
});

var newUnionConstructor = function(def){
    var Union = new OperatorConstructor(function(){
        return union().apply(null, def.apply(this, arguments));
    });
    return Union.new.bind(Union);
}

var translate = newUnionConstructor( function(dx){
    return this.children.map( c => c.translate(dx) );
});


var rotate = newUnionConstructor( function(a,v){
    if (a instanceof Array){
        return this.children.map( c => c.rotateX(a[0]).rotateY(a[1]).rotateZ(a[2]) );   
    }
    else{
        return this.children.map( c=> c.rotate( [0,0,0], v, a ) );
    }
});

var mirror = newUnionConstructor( function(n){
    var plane = new CSG.Plane(CSG.Vector3D.Create(n[0], n[1], n[2]).unit(), 0)
    return this.children.map( c => c.mirrored(plane) );
});

var scale = newUnionConstructor( function(s){
    
    return this.children.map( c=> scaler( c.exe(),s ) );
});


var trippleMirror = newUnionConstructor(function(d){
    return this.children.map( c => union()(
                            translate( d )( c ),
        mirror( [0,0,1] )(  translate( d )( c )     ),
        mirror( [0,1,0] )(  translate( d )( c )     ),
        mirror( [0,1,0] )(  mirror([0,0,1])(    translate( d )( c ) )),
        mirror( [1,0,0] )(  translate( d )( c )     ),
        mirror( [1,0,0] )(  mirror([0,0,1])(    translate( d )( c ) )),
        mirror( [1,0,0] )(  mirror([0,1,0])(    translate( d )( c ) )),
        mirror( [1,0,0] )(  mirror([0,1,0])(    mirror([0,0,1])( translate( d )( c ) )))
    ));
});

var corner3 = newUnionConstructor(function(d){
    return this.children.map( c => union()(
                                                translate( d )( c ),
        rotate([-90,0,0])(  mirror([0,1,0])(    translate( d )( c ) )),
        rotate([0,90,0])(   mirror([1,0,0])(    translate( d )( c ) ))
    ));
});

var rotateQuarters = newUnionConstructor( function(d){
    return this.children.map( c => union()(
                                translate( d )( c ),
        rotate([90 ,0,0])(      translate( d )( c ) ),
        rotate([180,0,0])(      translate( d )( c ) ),
        rotate([270,0,0])(      translate( d )( c ) )
    ));
});

var screwInsert = newModuleConstructor( function(screw){
    var h = screw.insertH;
    var r = screw.insertR;
    return cylinder(h,r,r);
});

var screwHole = newModuleConstructor(function(screw, l){
    var capH = screw.capH;
    var capR = screw.capR;
    var screwR = screw.screwR;
    
    var body = cylinder(l-capH, screwR, screwR);
    var cap = cylinder(capH, screwR, capR);
    
    return union()(
        body,
        translate([0,0,l-capH])(cap)
    );
});

var uCube = newModuleConstructor(function(cubeSize){
    var fullSize = cubeSize.fullSize;
    var d = cubeSize.d;
    var size = cubeSize.size;
    var screw = cubeSize.screw;
    
    var interNodes = trippleMirror([-0.5*fullSize, -0.5*fullSize, -0.5*fullSize])(
		corner3([0.5*(fullSize-0.75*d), 0.25*d, 1.25*d]) (cube([0.75*d, 0.5*d, 0.5*d], true)),
		corner3([0.25*d, 0.5*(fullSize-0.75*d), 1.25*d]) (cube([0.5*d, 0.75*d, 0.5*d], true))
	);
	
	var body = difference()(
				cube(fullSize, true),
				trippleMirror([-0.5*fullSize, -0.5*fullSize, -0.5*fullSize])(
					corner3([d, d, 0]) ( cube([0.5*size + d, 0.5*size + d, 0.5*d]) )
				),
				trippleMirror([-0.5*fullSize, -0.5*fullSize, -0.5*fullSize])(
					corner3([d, d, 0]) ( cube([0.5*size + d, 0.5*size + d, 0.5*d]) ),
					corner3([1.5*d, 1.5*d, 0.5*d]) ( screwInsert(screw) )
				),
				corner3(0)( cube([size,size,size + 4*d],true))
	);
	
	var holes = union()(
	    rotateQuarters([0, 0.5*fullSize-d, -0.5*fullSize]) (screwInsert(screw)),
		rotate([0,0,90]) ( rotateQuarters([0, 0.5*fullSize-d, -0.5*fullSize]) (screwInsert(screw))),
		rotate([0,90,0]) ( rotateQuarters([0, 0.5*fullSize-d, -0.5*fullSize]) (screwInsert(screw))),

		rotateQuarters([0, -(0.5*fullSize-d), -0.5*fullSize]) (screwHole(screw, 2*d)),
		rotate([0,0,90]) ( rotateQuarters([0, -(0.5*fullSize-d), -0.5*fullSize]) (screwHole(screw, 2*d))),
		rotate([0,90,0]) ( rotateQuarters([0, -(0.5*fullSize-d), -0.5*fullSize]) (screwHole(screw, 2*d)))
	);
	return difference()(
    	union()(
    	    body,
    	    interNodes
    	),
    	holes
    );
});

function uCubeC(){
    var screw = {screwR: 1.75, capR: 3, capH: 2.5, insertH: 5, insertR: 2 };
    var cubeSize = {d:7, size:40, fullSize: 68, screw: screw};
    return uCube(cubeSize);
}






