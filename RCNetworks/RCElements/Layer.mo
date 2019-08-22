within RCNetworks.RCElements;
model Layer
  "Wall Layer consisting of variable number of RC elements: N C with (N+1) R "

  parameter Integer n(min = 1) = 1 "Number of C-elements:";
  parameter Modelica.SIunits.ThermalResistance R[n+1](
    each min=Modelica.Constants.small)
    "Vector of resistors, from port_a to port_b"
    annotation(Dialog(group="Thermal mass"));

  parameter Modelica.SIunits.HeatCapacity C[n](
    each min=Modelica.Constants.small)
    "Vector of heat capacities, from port_a to port_b"
    annotation(Dialog(group="Thermal mass"));

  parameter Modelica.SIunits.Temperature T_start
    "Initial temperature of capacities"
    annotation(Dialog(group="Thermal mass"));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    "Thermal heat port"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
    iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor thermCapExt[n](
    each T(start=T_start),
    final C=C)
    "Vector of thermal capacitors"
    annotation (Placement(transformation(extent={{-10,-38},{10,-58}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermResExt[n](
    final R = R[1:n])
    "Vector of thermal resistors connecting port_a and capacitors"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermResExtRem(
    final R=R[n + 1])
    "Single thermal resistor connecting least capacitor to port_b"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    "Thermal heat port"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

equation
  // Connecting inner elements thermResExt[i]--thermCapExt[i] to n groups
  for i in 1:n loop
    connect(thermResExt[i].port_b,thermCapExt[i].port)
    annotation (Line(points={{-20,0},{0,0},{0,-38}}, color={191,0,0}));
  end for;
  // Connecting groups between each other thermCapExt[i] -- thermResExt[i+1]
  for i in 1:n-1 loop
    connect(thermCapExt[i].port,thermResExt[i+1].port_a)
     annotation (Line(points={{0,-38},{0,-20},{-60,-20},{-60,0},{-40,0}},
                                                color={191,0,0}));
  end for;
  // Connecting first RC element to port_a ,
  // last RC-element to RExtRem and RExtRem to port_b
  connect(port_a,thermResExt[1].port_a)
    annotation (Line(points={{-100,0},{-40,0}},        color={191,0,0}));
  connect(thermCapExt[n].port,thermResExtRem.port_a)
  annotation (Line(points={{0,-38},{0,-20},{18,-20},{18,0},{40,0}},
                                                          color={191,0,0}));

  connect(thermResExtRem.port_b, port_b)
    annotation (Line(points={{60,0},{100,0}}, color={191,0,0}));
  annotation(defaultComponentName = "extWalRC",
  Diagram(coordinateSystem(preserveAspectRatio = false, extent=
  {{-100, -100}, {100, 120}})),           Documentation(info="<html>
  <p><code>ExteriorWall</code> represents heat conduction and heat storage
  within walls. It links a variable number <code>n</code> of thermal resistances
  and capacities to a series connection. <code>n</code> thus defines the spatial
  discretization of thermal effects within the wall. All effects are considered
  as one-dimensional normal to the wall&apos;s surface. This model is thought
  for exterior wall elements that contribute to heat transfer to the outdoor.
  The RC-chain is defined via a vector of capacities <code>CExt[n]</code> and a
  vector of resistances <code>RExt[n]</code>. Resistances and capacities are
  connected alternately, starting with the first resistance <code>RExt[1]</code>,
  from heat <code>port_a</code> to heat <code>port_b</code>. <code>RExtRem</code>
  is the resistance between the last capacity <code>CExt[end]</code> and the
  heat <code>port_b</code>.</p>
  <p align=\"center\"><img src=\"modelica://Buildings/Resources/Images/ThermalZones/ReducedOrder/RC/BaseClasses/ExtMassVarRC/ExtMassVarRC.png\" alt=\"image\"/> </p>
  </html>",  revisions=""),
              Icon(coordinateSystem(preserveAspectRatio=false,  extent=
  {{-100,-100},{100,120}}), graphics={  Rectangle(extent = {{-86, 60}, {-34, 26}},
   fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-28, 60}, {26, 26}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{32, 60}, {86, 26}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{0, 20}, {54, -14}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-60, 20}, {-6, -14}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-86, -20}, {-34, -54}}, fillColor = {255, 213, 170},
   fillPattern =  FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-28, -20}, {26, -54}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{32, -20}, {86, -54}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-60, -60}, {-6, -94}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{0, -60}, {54, -94}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-60, 100}, {-6, 66}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{0, 100}, {54, 66}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{60, -60}, {86, -92}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{60, 20}, {86, -14}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{60, 100}, {86, 66}}, fillColor = {255, 213, 170},
   fillPattern =  FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-86, -60}, {-66, -94}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-86, 20}, {-66, -14}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-86, 100}, {-66, 66}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}),
   Line(points = {{-90, 0}, {90, 0}}, color = {0, 0, 0}, thickness = 0.5,
   smooth = Smooth.None), Rectangle(extent = {{-74, 12}, {-26, -10}},
   lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255},
   fillPattern = FillPattern.Solid), Rectangle(extent = {{28, 12}, {76, -10}},
   lineColor = {0, 0, 0}, lineThickness =  0.5, fillColor = {255, 255, 255},
   fillPattern = FillPattern.Solid), Line(points = {{-1, 0}, {-1, -32}},
   color = {0, 0, 0}, thickness = 0.5, smooth = Smooth.None),
   Line(points = {{-18, -32}, {16, -32}}, pattern = LinePattern.None,
   thickness = 0.5, smooth = Smooth.None), Line(points = {{-18, -44}, {16, -44}},
   pattern = LinePattern.None, thickness = 0.5, smooth = Smooth.None),
   Text(extent={{-90,152},{90,114}},      lineColor = {0, 0, 255},
   textString = "%name"),
   Line(points = {{18, -32}, {-20, -32}}, color = {0, 0, 0}, thickness = 0.5,
   smooth = Smooth.None),
   Line(points = {{14, -44}, {-15, -44}}, color = {0, 0, 0}, thickness = 0.5,
   smooth = Smooth.None)}));
end Layer;
