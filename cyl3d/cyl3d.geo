// Controla a refinamento da malha --------------------------------------------
fact = 2;
ptsPERdeg = 0.25;

// Parametros -----------------------------------------------------------------
Rey = 100;
BLthick = 1/(Rey)^0.5;
nlayBL = 5;

beta_deg = 60;
beta = beta_deg*Pi/180;
href = 0.15;
hfar = 1;
hF = fact*href;

r0 = 0.5;
r1 = r0 + BLthick;
r2 = 1.5;
r3 = 6;
rb = r3/Sin(beta);

Lwake = 7;
Lexit = rb + Lwake + r3/2;

// Pontos ---------------------------------------------------------------------
Point(1) = {0, 0, 0, href};

Point(2) = {-r0, 0, 0, href};
Point(3) = {0, r0, 0, href};
Point(4) = {r0*Cos(beta), r0*Sin(beta), 0, href};
Point(5) = {r0, 0, 0, href};
Point(6) = {r0*Cos(beta), -r0*Sin(beta), 0, href};
Point(7) = {0, -r0, 0, href};

Point(8) = {-r1, 0, 0, href};
Point(9) = {0, r1, 0, href};
Point(10) = {r1*Cos(beta), r1*Sin(beta), 0, href};
Point(11) = {r1, 0, 0, href};
Point(12) = {r1*Cos(beta), -r1*Sin(beta), 0, href};
Point(13) = {0, -r1, 0, href};

Point(14) = {-r2, 0, 0, href};
Point(15) = {0, r2, 0, href};
Point(16) = {r2*Cos(beta), r2*Sin(beta), 0, href};
Point(17) = {r2, 0, 0, href};
Point(18) = {r2*Cos(beta), -r2*Sin(beta), 0, href};
Point(19) = {0, -r2, 0, href};

Point(20) = {-r3, 0, 0, hfar};
Point(21) = {0, r3, 0, hfar};
Point(22) = {Lexit, r3, 0, hfar};
Point(23) = {Lexit, 0, 0, hfar};
Point(24) = {Lexit, -r3, 0, hfar};
Point(25) = {0, -r3, 0, hfar};
Point(26) = {r3/Tan(beta), r3, 0, href};
Point(27) = {r3, 0, 0, href};
Point(28) = {r3/Tan(beta), -r3, 0, href};

// ----------------------------------------------------------------------------
Line(1) = {2, 8};
Line(2) = {3, 9};
Line(3) = {4, 10};
Line(4) = {5, 11};
Line(5) = {6, 12};
Line(6) = {7, 13};

Transfinite Curve {1} = nlayBL+1 Using Progression 1.0;
Transfinite Curve {2} = nlayBL+1 Using Progression 1.0;
Transfinite Curve {3} = nlayBL+1 Using Progression 1.0;
Transfinite Curve {4} = nlayBL+1 Using Progression 1.0;
Transfinite Curve {5} = nlayBL+1 Using Progression 1.0;
Transfinite Curve {6} = nlayBL+1 Using Progression 1.0;

// ----------------------------------------------------------------------------
Line(7) = {8, 14};
Line(8) = {9, 15};
Line(9) = {10, 16};
Line(10) = {11, 17};
Line(11) = {12, 18};
Line(12) = {13, 19};

L = r2-r1; hI = BLthick/nlayBL; PGratio = (L-hI)/(L-hF);
Npts1 = 1 + Round(Log(hF/hI)/Log(PGratio) + 1);
Transfinite Curve {7} = Npts1 Using Progression PGratio;
Transfinite Curve {8} = Npts1 Using Progression PGratio;
Transfinite Curve {9} = Npts1 Using Progression PGratio;
Transfinite Curve {10} = Npts1 Using Progression PGratio;
Transfinite Curve {11} = Npts1 Using Progression PGratio;
Transfinite Curve {12} = Npts1 Using Progression PGratio;

// ----------------------------------------------------------------------------
Line(13) = {14, 20};
Line(14) = {15, 21};
Line(15) = {16, 26};
Line(16) = {17, 27};
Line(17) = {18, 28};
Line(18) = {19, 25};

L = r3-r2;
Npts2 = 1 + Round(L/hF + 1);
Transfinite Curve {13} = Npts2 Using Progression 1.0;
Transfinite Curve {14} = Npts2 Using Progression 1.0;
Transfinite Curve {15} = Npts2 Using Progression 1.0;
Transfinite Curve {16} = Npts2 Using Progression 1.0;
Transfinite Curve {17} = Npts2 Using Progression 1.0;
Transfinite Curve {18} = Npts2 Using Progression 1.0;

// ----------------------------------------------------------------------------
Circle(19) = {2, 1, 3};
Circle(20) = {3, 1, 4};
Circle(21) = {4, 1, 5};
Circle(22) = {5, 1, 6};
Circle(23) = {6, 1, 7};
Circle(24) = {7, 1, 2};

Npts3 = 1 + Round(ptsPERdeg*90);
Npts4 = 1 + Round(ptsPERdeg*(90-beta_deg));
Npts5 = 1 + Round(ptsPERdeg*beta_deg);
Transfinite Curve {19} = Npts3 Using Progression 1.0;
Transfinite Curve {20} = Npts4 Using Progression 1.0;
Transfinite Curve {21} = Npts5 Using Progression 1.0;
Transfinite Curve {22} = Npts5 Using Progression 1.0;
Transfinite Curve {23} = Npts4 Using Progression 1.0;
Transfinite Curve {24} = Npts3 Using Progression 1.0;

// ----------------------------------------------------------------------------
Circle(25) = {8, 1, 9};
Circle(26) = {9, 1, 10};
Circle(27) = {10, 1, 11};
Circle(28) = {11, 1, 12};
Circle(29) = {12, 1, 13};
Circle(30) = {13, 1, 8};

Transfinite Curve {25} = Npts3 Using Progression 1.0;
Transfinite Curve {26} = Npts4 Using Progression 1.0;
Transfinite Curve {27} = Npts5 Using Progression 1.0;
Transfinite Curve {28} = Npts5 Using Progression 1.0;
Transfinite Curve {29} = Npts4 Using Progression 1.0;
Transfinite Curve {30} = Npts3 Using Progression 1.0;

// ----------------------------------------------------------------------------
Circle(31) = {14, 1, 15};
Circle(32) = {15, 1, 16};
Circle(33) = {16, 1, 17};
Circle(34) = {17, 1, 18};
Circle(35) = {18, 1, 19};
Circle(36) = {19, 1, 14};

Transfinite Curve {31} = Npts3 Using Progression 1.0;
Transfinite Curve {32} = Npts4 Using Progression 1.0;
Transfinite Curve {33} = Npts5 Using Progression 1.0;
Transfinite Curve {34} = Npts5 Using Progression 1.0;
Transfinite Curve {35} = Npts4 Using Progression 1.0;
Transfinite Curve {36} = Npts3 Using Progression 1.0;

// ----------------------------------------------------------------------------
Circle(37) = {20, 1, 21};
Line(38) = {21, 26};
Line(39) = {26, 27};
Line(40) = {27, 28};
Line(41) = {28, 25};
Circle(42) = {25, 1, 20};

Transfinite Curve {37} = Npts3 Using Progression 1.0;
Transfinite Curve {38} = Npts4 Using Progression 1.0;
Transfinite Curve {39} = Npts5 Using Progression 1.0;
Transfinite Curve {40} = Npts5 Using Progression 1.0;
Transfinite Curve {41} = Npts4 Using Progression 1.0;
Transfinite Curve {42} = Npts3 Using Progression 1.0;

// ----------------------------------------------------------------------------
Line(43) = {26, 22};
Line(44) = {22, 23};
Line(45) = {23, 24};
Line(46) = {24, 28};
Line(47) = {27, 23};

L = Lexit-r3;  
Npts6 = 1 + Round(L/hF + 1);
Transfinite Curve {43} = Npts6 Using Progression 1.0;
Transfinite Curve {44} = Npts5 Using Progression 1.0;
Transfinite Curve {45} = Npts5 Using Progression 1.0;
Transfinite Curve {46} = Npts6 Using Progression 1.0;
Transfinite Curve {47} = Npts6 Using Progression 1.0;

// ----------------------------------------------------------------------------
Curve Loop(1) = {1, 25, -2, -19}; Plane Surface(1) = {1};
Curve Loop(2) = {2, 26, -3, -20}; Plane Surface(2) = {2};
Curve Loop(3) = {3, 27, -4, -21}; Plane Surface(3) = {3};
Curve Loop(4) = {4, 28, -5, -22}; Plane Surface(4) = {4};
Curve Loop(5) = {5, 29, -6, -23}; Plane Surface(5) = {5};
Curve Loop(6) = {6, 30, -1, -24}; Plane Surface(6) = {6};
Curve Loop(7) = {7, 31, -8, -25}; Plane Surface(7) = {7};
Curve Loop(8) = {8, 32, -9, -26}; Plane Surface(8) = {8};
Curve Loop(9) = {9, 33, -10, -27}; Plane Surface(9) = {9};
Curve Loop(10) = {10, 34, -11, -28}; Plane Surface(10) = {10};
Curve Loop(11) = {11, 35, -12, -29}; Plane Surface(11) = {11};
Curve Loop(12) = {12, 36, -7, -30}; Plane Surface(12) = {12};
Curve Loop(13) = {13, 37, -14, -31}; Plane Surface(13) = {13};
Curve Loop(14) = {14, 38, -15, -32}; Plane Surface(14) = {14};
Curve Loop(15) = {15, 39, -16, -33}; Plane Surface(15) = {15};
Curve Loop(16) = {16, 40, -17, -34}; Plane Surface(16) = {16};
Curve Loop(17) = {17, 41, -18, -35}; Plane Surface(17) = {17};
Curve Loop(18) = {18, 42, -13, -36}; Plane Surface(18) = {18};
Curve Loop(19) = {43, 44, -47, -39}; Plane Surface(19) = {19};
Curve Loop(20) = {47, 45, 46, -40}; Plane Surface(20) = {20};
Transfinite Surface "*"; 
Recombine Surface "*";

// ----------------------------------------------------------------------------
h = 10*r0;
nelz = 10;
Extrude {0,0,h} {
    Surface{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}; 
    Layers{nelz,1};
    Recombine;
}
Coherence;

// ----------------------------------------------------------------------------
Physical Surface("Cylinder") = {68,90,112,134,156,178};
Physical Surface("Upper") = {346, 452}; 
Physical Surface("Lower") = {412, 482};
Physical Surface("Outlet") = {456, 478};
Physical Surface("Inlet") = {324, 434};
Physical Surface("Right") = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,19,20,16,17,18};
Physical Surface("Left") = {69,91,113,135,157,179,201,223,245,267,289,311,333,355,377,465,487,399,421,443};
Physical Volume("Inside") = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20};

// Sets the mesh element order --------------------------------------------------
Mesh.ElementOrder = 2;

// Sets the mesh version for exporting the mesh ---------------------------------
Mesh.MshFileVersion = 2.2;
