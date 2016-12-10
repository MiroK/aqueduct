// Essentially a sphere with radius R sitting on a cylinder with radius r and
// length l. R > r is required. The two things are joint smoothly. 
// By construction the domain has nataruly 3 types of surfaces
// associated with it: the spherical part above joint --> 1
//                     the joint part                 --> 2
//                     the cylindrical part           --> 3
// The opening of the cylinder is marked as 3
//----------------------------------------------------------------------------

// Mesh quality/size parameters
Mesh.Smoothing = 4;
Mesh.SmoothNormals = 4;
size = 0.5;                 // Uniform everywhere

// Geometrical parameters
R = 2;
r = 0.5;
l = 5;
q = 1.25*r;            // Control the curvature of the joint part

sA = q/R;
cA = Sqrt(R^2-q^2)/R;
tA = sA/cA;
dp = tA*(q-r);
d = (q-r)/cA;
A = Asin(q/R);
X = d*Tan((Pi/2+A)/2);
Cx = cA*(R+X);
Cy = sA*(R+X);

// Domain definition
Point(1) = {0, 0, 0, size};
Point(2) = {0, 0, R, size};
Point(3) = {R, 0, 0, size};
Point(4) = {q, 0, -Sqrt(R^2-q^2), size/4};
Point(5) = {r, 0, -Sqrt(R^2-r^2), size};
Point(6) = {Cy, 0, -Cx, size};
Point(7) = {r, 0, -Sqrt(R^2-q^2)-dp-d, size/4};
Point(8) = {r, 0, -l-R, size/4};

Circle(1) = {2, 1, 3};
Circle(2) = {3, 1, 4};
Circle(3) = {4, 6, 7};
Line(4) = {7, 8};

// Rotate the surface to get the lillopop shape
extr[] = Extrude{ {0,0,0}, {0,0,1}, {0,0,0}, Pi }{ Line{1};};
extr1[] = Extrude{ {0,0,0}, {0,0,1}, {0,0,0}, Pi }{ Line{extr[0]};};

extr[] = Extrude{ {0,0,0}, {0,0,1}, {0,0,0}, Pi }{ Line{2};};
extr1[] = Extrude{ {0,0,0}, {0,0,1}, {0,0,0}, Pi }{ Line{extr[0]};};

extr[] = Extrude{ {0,0,0}, {0,0,1}, {0,0,0}, Pi }{ Line{3};};
extr1[] = Extrude{ {0,0,0}, {0,0,1}, {0,0,0}, Pi }{ Line{extr[0]};};

extr[] = Extrude{ {0,0,0}, {0,0,1}, {0,0,0}, Pi }{ Line{4};};
extr1[] = Extrude{ {0,0,0}, {0,0,1}, {0,0,0}, Pi }{ Line{extr[0]};};

// Opening
Line Loop(37) = {35, 31};
Plane Surface(38) = {37};

// Physical Surfaces
Physical Surface(1) = {8, 12, 16, 20};
Physical Surface(2) = {28, 24};
Physical Surface(3) = {36, 32};
Physical Surface(4) = {38};

Surface Loop(39) = {20, 16, 24, 28, 36, 32, 38, 8, 12};
Volume(40) = {39};
Physical Volume(1) = {40};
