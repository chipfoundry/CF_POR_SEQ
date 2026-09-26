`timescale 1ns / 1ps

module tb_CF_POR_SEQ;
    integer errors;

    reg en_l;
    reg vpwr;
    reg vgnd;
    wire por_l;

    CF_POR_SEQ u_por (
        .por_l(por_l),
        .en_l(en_l),
        .vgnd(vgnd),
        .vpwr(vpwr)
    );

    task expect_bit;
        input got;
        input exp;
        input [8*32-1:0] tag;
        begin
            if (got !== exp) begin
                $display("FAIL %s got=%b exp=%b", tag, got, exp);
                errors = errors + 1;
            end else begin
                $display("PASS %s %b", tag, got);
            end
        end
    endtask

    initial begin
        errors = 0;
        vpwr = 1'b1;
        vgnd = 1'b0;
        en_l = 1'b0;
        u_por.u_core.trip_v = 1.6;
        u_por.u_core.vpwr_v = 1.8;
        #1;
        expect_bit(por_l, 1'b1, "rail valid");

        u_por.u_core.vpwr_v = 1.59;
        #1;
        expect_bit(por_l, 1'b0, "below trip");

        u_por.u_core.vpwr_v = 1.6;
        #1;
        expect_bit(por_l, 1'b1, "at trip");

        u_por.u_core.vpwr_v = 1.0;
        en_l = 1'b1;
        #1;
        expect_bit(por_l, 1'b1, "disabled");

        en_l = 1'b0;
        #1;
        expect_bit(por_l, 1'b0, "enabled brownout");

        if (errors == 0)
            $display("CF_POR_SEQ behavioral self-check passed");
        else
            $display("CF_POR_SEQ behavioral self-check FAILED %0d", errors);
        $finish(errors != 0);
    end
endmodule
