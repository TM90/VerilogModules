module servo_cntrl_tb();

    parameter PERIOD = 20;
    
    wire clk;
    reg res_n;
    reg[7:0] servo_data0 = 0;
    reg[7:0] servo_data1 = 0;
    reg[7:0] servo_data2 = 0;
    reg[7:0] servo_data3 = 0;
    reg[7:0] servo_data4 = 0;
    reg[7:0] servo_data5 = 0;
    reg[7:0] servo_data6 = 0;
    reg[7:0] servo_data7 = 0;
    reg[7:0] servo_data8 = 0;
    reg[7:0] servo_data9 = 0;
    reg[7:0] servo_data10 = 0;
    reg[7:0] servo_data11 = 0;
    reg[7:0] servo_data12 = 0;
    reg[7:0] servo_data13 = 0;
    reg[7:0] servo_data14 = 0;
    reg[7:0] servo_data15 = 0;
    reg[7:0] servo_data16 = 0;
    reg[7:0] servo_data17 = 0;
    wire[17:0] servo_signal;
    clk_gen #(.period(PERIOD)) clk_gen_I (.clk_out(clk));
   
    servo_cntrl #(
        .SERVO_CNT(18),
        .RESOLUTION(8),
        .FREQ(50000000),
        .COMPARE(1000000),
        .COMPARE_PULSE(195),
        .COMPARE_REG20MS(20),
        .COMPARE_REGPULSE(8) 
    )
    servo_cntrl_I(
        .clk(clk),
        .res_n(res_n), 
        .servo_data0(servo_data0),
        .servo_data1(servo_data1),
        .servo_data2(servo_data2),
        .servo_data3(servo_data3),
        .servo_data4(servo_data4),
        .servo_data5(servo_data5),
        .servo_data6(servo_data6),
        .servo_data7(servo_data7),
        .servo_data8(servo_data8),
        .servo_data9(servo_data9),
        .servo_data10(servo_data10),
        .servo_data11(servo_data11),
        .servo_data12(servo_data12),
        .servo_data13(servo_data13),
        .servo_data14(servo_data14),
        .servo_data15(servo_data15),
        .servo_data16(servo_data16),
        .servo_data17(servo_data17),
        .servo_signal(servo_signal)
    );

    initial 
    begin
        $dumpfile("servo_cntrl.vcd");
        $dumpvars(0,servo_cntrl_tb);
        #40000000
        $stop;
    end

endmodule
