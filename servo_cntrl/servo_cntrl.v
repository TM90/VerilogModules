module servo_cntrl 
#(
    parameter SERVO_CNT = 18,
    parameter RESOLUTION = 8,
    parameter FREQ = 50000000,
    parameter COMPARE = 1000000,
    parameter COMPARE_PULSE = 195,
    parameter COMPARE_REG20MS = 20,
    parameter COMPARE_REGPULSE = 8
)
(
    input clk,
    input res_n,
    input wire[RESOLUTION-1:0] servo_data0,
    input wire[RESOLUTION-1:0] servo_data1,
    input wire[RESOLUTION-1:0] servo_data2,
    input wire[RESOLUTION-1:0] servo_data3,
    input wire[RESOLUTION-1:0] servo_data4,
    input wire[RESOLUTION-1:0] servo_data5,
    input wire[RESOLUTION-1:0] servo_data6,
    input wire[RESOLUTION-1:0] servo_data7,
    input wire[RESOLUTION-1:0] servo_data8,
    input wire[RESOLUTION-1:0] servo_data9,
    input wire[RESOLUTION-1:0] servo_data10,
    input wire[RESOLUTION-1:0] servo_data11,
    input wire[RESOLUTION-1:0] servo_data12,
    input wire[RESOLUTION-1:0] servo_data13,
    input wire[RESOLUTION-1:0] servo_data14,
    input wire[RESOLUTION-1:0] servo_data15,
    input wire[RESOLUTION-1:0] servo_data16,
    input wire[RESOLUTION-1:0] servo_data17,
    output reg[SERVO_CNT-1:0] servo_signal
);

    reg[COMPARE_REG20MS-1:0] compare_reg20m = 0;
    reg[COMPARE_REGPULSE-1:0] compare_regpulse = 0;
    reg tick20m;
    reg tick_pulse;
    reg[COMPARE_REGPULSE:0] tick_cnt [0:SERVO_CNT-1];
    reg[1:0] states = 0; 
    wire[RESOLUTION-1:0] servo_data_int [0:SERVO_CNT-1];

    assign servo_data_int[0] = servo_data0;
    assign servo_data_int[1] = servo_data1;
    assign servo_data_int[2] = servo_data2;
    assign servo_data_int[3] = servo_data3;
    assign servo_data_int[4] = servo_data4;
    assign servo_data_int[5] = servo_data5;
    assign servo_data_int[6] = servo_data6;
    assign servo_data_int[7] = servo_data7;
    assign servo_data_int[8] = servo_data8;
    assign servo_data_int[9] = servo_data9;
    assign servo_data_int[10] = servo_data10;
    assign servo_data_int[11] = servo_data11;
    assign servo_data_int[12] = servo_data12;
    assign servo_data_int[13] = servo_data13;
    assign servo_data_int[14] = servo_data14;
    assign servo_data_int[15] = servo_data15;
    assign servo_data_int[16] = servo_data16;
    assign servo_data_int[17] = servo_data17;

    // Generates 20ms tick
    always @(posedge clk)
    begin
        if(compare_reg20m == COMPARE)
        begin
            compare_reg20m <= 0;
            tick20m <= 1'b1;
        end
        else
        begin
            compare_reg20m <= compare_reg20m + 1'b1;
            tick20m <= 1'b0;
        end
    end

    // Generates tick for pulse
    always @(posedge clk)
    begin
        if(compare_regpulse == COMPARE_PULSE)
        begin
            compare_regpulse <= 0;
            tick_pulse <= 1'b1;
        end
        else
        begin
            compare_regpulse <= compare_regpulse + 1'b1;
            tick_pulse <= 1'b0;
        end
    end

    genvar i;
    generate 
        for(i = 0; i < SERVO_CNT; i = i + 1) begin: SERVO_CNTRL_COMPARE
            always @(posedge clk)
            begin
                case(states)
                    2'b00:
                    begin
                        tick_cnt[i] <= 0;
                        if(tick20m == 1'b1)
                        begin
                            states <= 2'b01;
                        end
                    end
                    2'b01:
                    begin
                        servo_signal[i] <= 1'b1;
                        if(tick_pulse == 1'b1)
                        begin
                            tick_cnt[i] <= tick_cnt[i] +1'b1;
                        end
                        if(tick_cnt[i] >= 256 + servo_data_int[i])
                        begin
                            servo_signal <= 1'b0;
                            states <= 2'b00;
                        end
                    end
                    default:
                    begin
                        states <= 1'b00;
                    end
                endcase
            end    
        end
    endgenerate
endmodule
