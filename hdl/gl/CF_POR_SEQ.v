// Structural PG wrapper. Analog leaf is CF_POR_SEQ_core.
// Customer rails are vpwr/vgnd; well taps vpb/vnb/vpbe are tied inside.
module CF_POR_SEQ (
    por_l,
    en_l,
    vgnd,
    vpwr
);
    output por_l;
    input en_l;
    input vgnd;
    input vpwr;
    CF_POR_SEQ_core u_core (
        .por_l(por_l),
        .en_l(en_l),
        .vgnd(vgnd),
        .vpwr(vpwr)
    );
endmodule
