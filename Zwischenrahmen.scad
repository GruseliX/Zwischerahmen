//---------------------------------------------------------
//
//  Lichtschalter Zwischenrahmen 
//  rcece
//  v0.0
//
//---------------------------------------------------------

$fn = $preview ? 32 : 64; 
$fs = 0.01;
$fa = 0.01;

mainPlain = [68,68,6];
corner = [
    6,
    [6,6,mainPlain[2]-6],
    [6,mainPlain[1]-6,mainPlain[2]-6],
    [mainPlain[0]-6,mainPlain[1]-6,mainPlain[2]-6],
    [mainPlain[0]-6,6,mainPlain[2]-6]
];
cutSwitchDim = [
    4,
    [4,4,-1],
    [4,50-4,-1],
    [50-4,50-4,-1],
    [50-4,4,-1],
    [50,50,8]
];
cutBottomDim = [
    4,
    [4,4,-1],
    [4,63-4,-1],
    [63-4,63-4,-1],
    [63-4,4,-1],
    [63,63,4],
];

clampPlaneDim = [
    [[0,0],
    [0,10],
    [10,10],
    [10,0]],
    7,
    1
];


shape();

module shape(){
    union(){
        difference(){
            groundPlate([0,0,0],[0,0,0]);
            cutSwitch([(mainPlain[0]-cutSwitchDim[5][0])/2,(mainPlain[1]-cutSwitchDim[5][1])/2,0],[0,0,0]);
            cutBottom([(mainPlain[0]-cutBottomDim[5][0])/2,(mainPlain[1]-cutBottomDim[5][1])/2,0],[0,0,0]);
        }   
        clampPlane([9,9,3],[0,0,0]);
        clampPlane([mainPlain[0]-9,9,3],[0,0,-270]);
        clampPlane([mainPlain[0]-9,mainPlain[0]-9,3],[0,0,-180]);
        clampPlane([9,mainPlain[0]-9,3],[0,0,-90]);
    }
}


module groundPlate(pos,rot){
    translate(pos){
        rotate(rot){
            difference(){
            hull(){
                translate(corner[1]){
                    sphere(r=6);
                }
                translate(corner[2]){
                    sphere(r=6);
                }
                translate(corner[3]){
                    sphere(r=6);
                }
                translate(corner[4]){
                    sphere(r=6);
                }
            }
            translate([0,0,-6]){
                cube([70,70,6]);
            }
            }
        }
    }
}

module cutSwitch(pos,rot){
    translate(pos){
        rotate(rot){
            hull(){
                translate(cutSwitchDim[1])
                    cylinder(r=4,h=8);
                translate(cutSwitchDim[2])
                    cylinder(r=4,h=8);
                translate(cutSwitchDim[3])
                    cylinder(r=4,h=8);
                translate(cutSwitchDim[4])
                    cylinder(r=4,h=8);

            }
        }
    }
}

module cutBottom(pos,rot){
    translate(pos){
        rotate(rot){
            hull(){
                translate(cutBottomDim[1])
                    cylinder(r=cutBottomDim[0],h=cutBottomDim[5][2]);
                translate(cutBottomDim[2])
                    cylinder(r=cutBottomDim[0],h=cutBottomDim[5][2]);
                translate(cutBottomDim[3])
                    cylinder(r=cutBottomDim[0],h=cutBottomDim[5][2]);
                translate(cutBottomDim[4])
                    cylinder(r=cutBottomDim[0],h=cutBottomDim[5][2]);

            }
        }
    }

}

module clampPlane(pos, rot){
     translate(pos){
        rotate(rot){
            linear_extrude(height=clampPlaneDim[2]){
                difference(){
                    square(size=[10, 10], center=false);
                    translate([10,10,0]){
                        circle(r=clampPlaneDim[1]);
                    }
                }
            }
        }
    }

}

