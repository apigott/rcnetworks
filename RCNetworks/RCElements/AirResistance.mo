within RCNetworks.RCElements;
model AirResistance "Convective air resistance at exterior or interior walls"
  extends RCNetworks.BaseClasses.PartialAirResistanceIcon;

  parameter Modelica.SIunits.ThermalResistance R
    "Constant thermal resistance";

  Modelica.Thermal.HeatTransfer.Components.ThermalResistor res(R=R)
    "Convective resistance"
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    "Thermal heat port"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a "Heat port"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  connect(res.port_b, port_b)
    annotation (Line(points={{12,0},{100,0}}, color={191,0,0}));
  connect(res.port_a, port_a)
    annotation (Line(points={{-8,0},{-100,0}}, color={191,0,0}));
  annotation (
  Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end AirResistance;
