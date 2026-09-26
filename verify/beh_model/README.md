# CF_POR_SEQ behavioral model

Ideal functional model for digital simulation. It is **not** SPICE-accurate
and it is **not** a silicon trip-point. Use it to exercise reset sequencing.
Do not add this file to OpenLane `VERILOG_FILES`.

## Files

| File | Replaces |
|---|---|
| `CF_POR_SEQ_core.v` | `hdl/gl/CF_POR_SEQ_core.v` |

Keep the customer wrap in `hdl/gl/CF_POR_SEQ.v`. Do **not** compile the empty
`hdl/gl/CF_POR_SEQ_core.v` stub in the same sim (duplicate module name).

```bash
./verify/beh_model/run_tb.sh
```

## Supply stimulus

`vpwr` is a 1-bit net. The rail voltage lives on a Verilog `real` backdoor:

```verilog
u_por.u_core.vpwr_v = 1.8;   // at or above trip_v → por_l released
u_por.u_core.trip_v = 1.6;   // assumed default, not a characterized trip
```

## Assumed protocol

`en_l` low runs the detector. `por_l` is asserted (0) while `vpwr_v` is below
`trip_v`, and released (1) once the rail reaches the trip.

`en_l` high turns the detector off and releases `por_l`. Hysteresis and
startup delay are not modeled.
