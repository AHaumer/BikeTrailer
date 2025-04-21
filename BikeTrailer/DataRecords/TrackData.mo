within BikeTrailer.DataRecords;
record TrackData "Description of track"
  extends Modelica.Icons.Record;
  parameter Real trackTable[:, 5]={
    {  0,  0,  0, 0.05,  0.0},
    { 60, 25,  0, 0.05,  0.0},
    {120, 25, -5, 0.05,  0.0},
    {120, 25, -5, 0.05,  0.1},
    {180, 20,  0, 0.05,  0.1},
    {180, 20,  0, 0.05, -0.1},
    {240, 30,  5, 0.05, -0.1},
    {240, 30,  5, 0.05,  0.0},
    {300, 25,  0, 0.05,  0.0},
    {360,  0,  0, 0.05,  0.0},
    {420,  0,  0, 0.05,  0.0}} "time, velocity, windSpeed, rollingResistance, inclination";
  annotation (defaultComponentPrefixes="parameter");
end TrackData;
