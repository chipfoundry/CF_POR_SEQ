`timescale 1ns / 1ps

// Ideal functional model of analog leaf CF_POR_SEQ_core.
// Drop this file in place of hdl/gl/CF_POR_SEQ_core.v for simulation.
// Do not add it to OpenLane VERILOG_FILES.
//
// The 1-bit vpwr pin stays digital. Rail voltage is the real backdoor vpwr_v.
//
// Assumed protocol (ideal, not silicon-verified):
//   * en_l high → detector off, por_l released (1)
//   * en_l low and vpwr_v < trip_v → por_l asserted (0)
//   * en_l low and vpwr_v >= trip_v → por_l released (1)
// Default trip_v is 1.6 V. Hysteresis and startup delay are not modeled.

module CF_POR_SEQ_core (
    por_l,
    en_l,
    vgnd,
    vpwr
);
    output por_l;
    input en_l;
    input vgnd;
    input vpwr;

    localparam real TRIP_DEFAULT = 1.6;
    localparam real VPWR_DEFAULT = 1.8;

    real vpwr_v;
    real trip_v;

    initial begin
        vpwr_v = VPWR_DEFAULT;
        trip_v = TRIP_DEFAULT;
    end

    assign por_l = (en_l || (vpwr_v >= trip_v)) ? 1'b1 : 1'b0;
endmodule
