
//Verilog file of module top_convolver


`timescale 1 ns / 1ns

module top_convolver_net(clk,
rst,
valid_in,
pixel_1,
pixel_2,
pixel_3,
coeff_11,
coeff_12,
coeff_13,
coeff_21,
coeff_22,
coeff_23,
coeff_31,
coeff_32,
coeff_33,
valid_out,
conv_result,
NbarT,
Si1, Si2, Si3,
So1, So2, So3
);
    input    clk;
    input    rst;
    input    valid_in;
    input    pixel_1;
    input    pixel_2;
    input    pixel_3;
    input    coeff_11;
    input    coeff_12;
    input    coeff_13;
    input    coeff_21;
    input    coeff_22;
    input    coeff_23;
    input    coeff_31;
    input    coeff_32;
    input    coeff_33;
    input NbarT;
    input Si1, Si2, Si3;
    output   valid_out;
    output So1, So2, So3;
output [0:3]conv_result;
wire
top_convolver_wire_1,
top_convolver_wire_2,
top_convolver_wire_3,
top_convolver_wire_4,
top_convolver_wire_5,
top_convolver_wire_6,
top_convolver_wire_7,
top_convolver_wire_8,
top_convolver_wire_9,
top_convolver_wire_10,
top_convolver_wire_11,
top_convolver_wire_12,
top_convolver_wire_13,
top_convolver_wire_14,
top_convolver_wire_15,
top_convolver_wire_16,
top_convolver_wire_17,
top_convolver_wire_18,
top_convolver_wire_19,
top_convolver_wire_20,
top_convolver_wire_21,
top_convolver_wire_22,
top_convolver_wire_23,
top_convolver_wire_24,
top_convolver_wire_25,
top_convolver_wire_26,
top_convolver_wire_27,
top_convolver_wire_28,
top_convolver_wire_29,
top_convolver_wire_30,
top_convolver_wire_31,
top_convolver_wire_32,
top_convolver_wire_33,
top_convolver_wire_34,
top_convolver_wire_35,
top_convolver_wire_36,
top_convolver_wire_37,
top_convolver_wire_38,
top_convolver_wire_39,
top_convolver_wire_40,
top_convolver_wire_41,
top_convolver_wire_42,
top_convolver_wire_43,
top_convolver_wire_44,
top_convolver_wire_45,
top_convolver_wire_46,
top_convolver_wire_47,
top_convolver_wire_48,
top_convolver_wire_49,
top_convolver_wire_50,
top_convolver_wire_51,
top_convolver_wire_52,
top_convolver_wire_53,
top_convolver_wire_54,
top_convolver_wire_55,
top_convolver_wire_56,
top_convolver_wire_57,
top_convolver_wire_58,
top_convolver_wire_59,
top_convolver_wire_60,
top_convolver_wire_61,
top_convolver_wire_62,
top_convolver_wire_63,
top_convolver_wire_64,
top_convolver_wire_65,
top_convolver_wire_66,
top_convolver_wire_67,
top_convolver_wire_68,
top_convolver_wire_69,
top_convolver_wire_70,
top_convolver_wire_71,
top_convolver_wire_72,
top_convolver_wire_73,
top_convolver_wire_74,
top_convolver_wire_75,
top_convolver_wire_76,
top_convolver_wire_77,
top_convolver_wire_78,
top_convolver_wire_79,
top_convolver_wire_80,
top_convolver_wire_81,
top_convolver_wire_82,
top_convolver_wire_83,
top_convolver_wire_84,
top_convolver_wire_85,
top_convolver_wire_86,
top_convolver_wire_87,
top_convolver_wire_88,
top_convolver_wire_89,
top_convolver_wire_90,
top_convolver_wire_91,
top_convolver_wire_92,
top_convolver_wire_93,
top_convolver_wire_94,
top_convolver_wire_95,
top_convolver_wire_96,
top_convolver_wire_97,
top_convolver_wire_98,
top_convolver_wire_99,
top_convolver_wire_100,
top_convolver_wire_101,
top_convolver_wire_102,
top_convolver_wire_103,
top_convolver_wire_104,
top_convolver_wire_105,
top_convolver_wire_106,
top_convolver_wire_107,
top_convolver_wire_108,
top_convolver_wire_109,
top_convolver_wire_110,
top_convolver_wire_111,
top_convolver_wire_112,
top_convolver_wire_113,
top_convolver_wire_114,
top_convolver_wire_115,
top_convolver_wire_116,
top_convolver_wire_117,
top_convolver_wire_118,
top_convolver_wire_119,
top_convolver_wire_120,
top_convolver_wire_121,
top_convolver_wire_122,
top_convolver_wire_123,
top_convolver_wire_124,
top_convolver_wire_125,
top_convolver_wire_126,
top_convolver_wire_127,
top_convolver_wire_128,
top_convolver_wire_129,
top_convolver_wire_130,
top_convolver_wire_131,
top_convolver_wire_132,
top_convolver_wire_133,
top_convolver_wire_134,
top_convolver_wire_135,
top_convolver_wire_136,
top_convolver_wire_137,
top_convolver_wire_138,
top_convolver_wire_139,
top_convolver_wire_14_0,
top_convolver_wire_14_1,
top_convolver_wire_9_0,
top_convolver_wire_9_1,
top_convolver_wire_9_2,
top_convolver_wire_31_0,
top_convolver_wire_31_1,
top_convolver_wire_54_0,
top_convolver_wire_54_1,
top_convolver_wire_49_0,
top_convolver_wire_49_1,
top_convolver_wire_49_2,
top_convolver_wire_37_0,
top_convolver_wire_37_1,
top_convolver_wire_43_0,
top_convolver_wire_43_1,
top_convolver_wire_19_0,
top_convolver_wire_19_1,
top_convolver_wire_22_0,
top_convolver_wire_22_1,
top_convolver_wire_25_0,
top_convolver_wire_25_1,
top_convolver_wire_18_0,
top_convolver_wire_18_1,
top_convolver_wire_21_0,
top_convolver_wire_21_1,
top_convolver_wire_24_0,
top_convolver_wire_24_1,
top_convolver_wire_27_0,
top_convolver_wire_27_1,
top_convolver_wire_33_0,
top_convolver_wire_33_1,
top_convolver_wire_39_0,
top_convolver_wire_39_1,
top_convolver_wire_28_0,
top_convolver_wire_28_1,
top_convolver_wire_34_0,
top_convolver_wire_34_1,
top_convolver_wire_40_0,
top_convolver_wire_40_1,
top_convolver_wire_50_0,
top_convolver_wire_50_1,
top_convolver_wire_50_2,
top_convolver_wire_55_0,
top_convolver_wire_55_1,
top_convolver_wire_55_2,
top_convolver_wire_46_0,
top_convolver_wire_46_1,
top_convolver_wire_51_0,
top_convolver_wire_51_1,
top_convolver_wire_51_2,
top_convolver_wire_56_0,
top_convolver_wire_56_1,
top_convolver_wire_56_2,
top_convolver_wire_45_0,
top_convolver_wire_45_1,
top_convolver_wire_11_0,
top_convolver_wire_11_1,
top_convolver_wire_11_2,
top_convolver_wire_16_0,
top_convolver_wire_16_1,
top_convolver_wire_16_2,
top_convolver_wire_2_0,
top_convolver_wire_2_1,
top_convolver_wire_10_0,
top_convolver_wire_10_1,
top_convolver_wire_10_2,
top_convolver_wire_15_0,
top_convolver_wire_15_1,
top_convolver_wire_15_2,
top_convolver_wire_3_0,
top_convolver_wire_3_1,
top_convolver_wire_108_0,
top_convolver_wire_108_1,
top_convolver_wire_101_0,
top_convolver_wire_101_1,
top_convolver_wire_109_0,
top_convolver_wire_109_1,
top_convolver_wire_110_0,
top_convolver_wire_110_1,
top_convolver_wire_111_0,
top_convolver_wire_111_1,
top_convolver_wire_112_0,
top_convolver_wire_112_1,
top_convolver_wire_117_0,
top_convolver_wire_117_1,
top_convolver_wire_65_0,
top_convolver_wire_65_1,
top_convolver_wire_65_2,
top_convolver_wire_65_3,
top_convolver_wire_65_4,
top_convolver_wire_65_5,
top_convolver_wire_119_0,
top_convolver_wire_119_1,
top_convolver_wire_119_2,
top_convolver_wire_123_0,
top_convolver_wire_123_1,
top_convolver_wire_123_2,
top_convolver_wire_127_0,
top_convolver_wire_127_1,
top_convolver_wire_127_2,
top_convolver_wire_102_0,
top_convolver_wire_102_1,
top_convolver_wire_102_2,
top_convolver_wire_102_3,
top_convolver_wire_102_4,
top_convolver_wire_138_0,
top_convolver_wire_138_1,
clk_net_0,
rst_net_0,
valid_in_net_0,
pixel_1_net_0,
pixel_2_net_0,
pixel_3_net_0,
coeff_11_net_0,
coeff_12_net_0,
coeff_13_net_0,
coeff_21_net_0,
coeff_22_net_0,
coeff_23_net_0,
coeff_31_net_0,
coeff_32_net_0,
coeff_33_net_0,
valid_out_net_0;

pin #(15) pin_0 ({clk, rst, valid_in, pixel_1, pixel_2, pixel_3, coeff_11, coeff_12, coeff_13, coeff_21, coeff_22, coeff_23, coeff_31, coeff_32, coeff_33}, {clk_net_0, rst_net_0, valid_in_net_0, pixel_1_net_0, pixel_2_net_0, pixel_3_net_0, coeff_11_net_0, coeff_12_net_0, coeff_13_net_0, coeff_21_net_0, coeff_22_net_0, coeff_23_net_0, coeff_31_net_0, coeff_32_net_0, coeff_33_net_0});

pout #(5) pout_0 ({valid_out_net_0, conv_result_0, conv_result_1, conv_result_2, conv_result_3}, {valid_out, conv_result[0], conv_result[1], conv_result[2], conv_result[3]});

fanout_n #(2, 0, 0) FANOUT_1 (top_convolver_wire_14, {top_convolver_wire_14_0, top_convolver_wire_14_1});
fanout_n #(3, 0, 0) FANOUT_2 (top_convolver_wire_9, {top_convolver_wire_9_0, top_convolver_wire_9_1, top_convolver_wire_9_2});
fanout_n #(2, 0, 0) FANOUT_3 (top_convolver_wire_31, {top_convolver_wire_31_0, top_convolver_wire_31_1});
fanout_n #(2, 0, 0) FANOUT_4 (top_convolver_wire_54, {top_convolver_wire_54_0, top_convolver_wire_54_1});
fanout_n #(3, 0, 0) FANOUT_5 (top_convolver_wire_49, {top_convolver_wire_49_0, top_convolver_wire_49_1, top_convolver_wire_49_2});
fanout_n #(2, 0, 0) FANOUT_6 (top_convolver_wire_37, {top_convolver_wire_37_0, top_convolver_wire_37_1});
fanout_n #(2, 0, 0) FANOUT_7 (top_convolver_wire_43, {top_convolver_wire_43_0, top_convolver_wire_43_1});
fanout_n #(2, 0, 0) FANOUT_8 (top_convolver_wire_19, {top_convolver_wire_19_0, top_convolver_wire_19_1});
fanout_n #(2, 0, 0) FANOUT_9 (top_convolver_wire_22, {top_convolver_wire_22_0, top_convolver_wire_22_1});
fanout_n #(2, 0, 0) FANOUT_10 (top_convolver_wire_25, {top_convolver_wire_25_0, top_convolver_wire_25_1});
fanout_n #(2, 0, 0) FANOUT_11 (top_convolver_wire_18, {top_convolver_wire_18_0, top_convolver_wire_18_1});
fanout_n #(2, 0, 0) FANOUT_12 (top_convolver_wire_21, {top_convolver_wire_21_0, top_convolver_wire_21_1});
fanout_n #(2, 0, 0) FANOUT_13 (top_convolver_wire_24, {top_convolver_wire_24_0, top_convolver_wire_24_1});
fanout_n #(2, 0, 0) FANOUT_14 (top_convolver_wire_27, {top_convolver_wire_27_0, top_convolver_wire_27_1});
fanout_n #(2, 0, 0) FANOUT_15 (top_convolver_wire_33, {top_convolver_wire_33_0, top_convolver_wire_33_1});
fanout_n #(2, 0, 0) FANOUT_16 (top_convolver_wire_39, {top_convolver_wire_39_0, top_convolver_wire_39_1});
fanout_n #(2, 0, 0) FANOUT_17 (top_convolver_wire_28, {top_convolver_wire_28_0, top_convolver_wire_28_1});
fanout_n #(2, 0, 0) FANOUT_18 (top_convolver_wire_34, {top_convolver_wire_34_0, top_convolver_wire_34_1});
fanout_n #(2, 0, 0) FANOUT_19 (top_convolver_wire_40, {top_convolver_wire_40_0, top_convolver_wire_40_1});
fanout_n #(3, 0, 0) FANOUT_20 (top_convolver_wire_50, {top_convolver_wire_50_0, top_convolver_wire_50_1, top_convolver_wire_50_2});
fanout_n #(3, 0, 0) FANOUT_21 (top_convolver_wire_55, {top_convolver_wire_55_0, top_convolver_wire_55_1, top_convolver_wire_55_2});
fanout_n #(2, 0, 0) FANOUT_22 (top_convolver_wire_46, {top_convolver_wire_46_0, top_convolver_wire_46_1});
fanout_n #(3, 0, 0) FANOUT_23 (top_convolver_wire_51, {top_convolver_wire_51_0, top_convolver_wire_51_1, top_convolver_wire_51_2});
fanout_n #(3, 0, 0) FANOUT_24 (top_convolver_wire_56, {top_convolver_wire_56_0, top_convolver_wire_56_1, top_convolver_wire_56_2});
fanout_n #(2, 0, 0) FANOUT_25 (top_convolver_wire_45, {top_convolver_wire_45_0, top_convolver_wire_45_1});
fanout_n #(3, 0, 0) FANOUT_26 (top_convolver_wire_11, {top_convolver_wire_11_0, top_convolver_wire_11_1, top_convolver_wire_11_2});
fanout_n #(3, 0, 0) FANOUT_27 (top_convolver_wire_16, {top_convolver_wire_16_0, top_convolver_wire_16_1, top_convolver_wire_16_2});
fanout_n #(2, 0, 0) FANOUT_28 (top_convolver_wire_2, {top_convolver_wire_2_0, top_convolver_wire_2_1});
fanout_n #(3, 0, 0) FANOUT_29 (top_convolver_wire_10, {top_convolver_wire_10_0, top_convolver_wire_10_1, top_convolver_wire_10_2});
fanout_n #(3, 0, 0) FANOUT_30 (top_convolver_wire_15, {top_convolver_wire_15_0, top_convolver_wire_15_1, top_convolver_wire_15_2});
fanout_n #(2, 0, 0) FANOUT_31 (top_convolver_wire_3, {top_convolver_wire_3_0, top_convolver_wire_3_1});
fanout_n #(2, 0, 0) FANOUT_32 (top_convolver_wire_108, {top_convolver_wire_108_0, top_convolver_wire_108_1});
fanout_n #(2, 0, 0) FANOUT_33 (top_convolver_wire_101, {top_convolver_wire_101_0, top_convolver_wire_101_1});
fanout_n #(2, 0, 0) FANOUT_34 (top_convolver_wire_109, {top_convolver_wire_109_0, top_convolver_wire_109_1});
fanout_n #(2, 0, 0) FANOUT_35 (top_convolver_wire_110, {top_convolver_wire_110_0, top_convolver_wire_110_1});
fanout_n #(2, 0, 0) FANOUT_36 (top_convolver_wire_111, {top_convolver_wire_111_0, top_convolver_wire_111_1});
fanout_n #(2, 0, 0) FANOUT_37 (top_convolver_wire_112, {top_convolver_wire_112_0, top_convolver_wire_112_1});
fanout_n #(2, 0, 0) FANOUT_38 (top_convolver_wire_117, {top_convolver_wire_117_0, top_convolver_wire_117_1});
fanout_n #(6, 0, 0) FANOUT_39 (top_convolver_wire_65, {top_convolver_wire_65_0, top_convolver_wire_65_1, top_convolver_wire_65_2, top_convolver_wire_65_3, top_convolver_wire_65_4, top_convolver_wire_65_5});
fanout_n #(3, 0, 0) FANOUT_40 (top_convolver_wire_119, {top_convolver_wire_119_0, top_convolver_wire_119_1, top_convolver_wire_119_2});
fanout_n #(3, 0, 0) FANOUT_41 (top_convolver_wire_123, {top_convolver_wire_123_0, top_convolver_wire_123_1, top_convolver_wire_123_2});
fanout_n #(3, 0, 0) FANOUT_42 (top_convolver_wire_127, {top_convolver_wire_127_0, top_convolver_wire_127_1, top_convolver_wire_127_2});
fanout_n #(5, 0, 0) FANOUT_43 (top_convolver_wire_102, {top_convolver_wire_102_0, top_convolver_wire_102_1, top_convolver_wire_102_2, top_convolver_wire_102_3, top_convolver_wire_102_4});
fanout_n #(2, 0, 0) FANOUT_44 (top_convolver_wire_138, {top_convolver_wire_138_0, top_convolver_wire_138_1});


xor_n #(2, 0, 0) XOR_1 (top_convolver_wire_1, {top_convolver_wire_2_0, top_convolver_wire_3_0});
xor_n #(2, 0, 0) XOR_2 (top_convolver_wire_4, {top_convolver_wire_5, top_convolver_wire_6});
xor_n #(2, 0, 0) XOR_3 (top_convolver_wire_7, {top_convolver_wire_8, top_convolver_wire_9_0});
xor_n #(2, 0, 0) XOR_4 (top_convolver_wire_8, {top_convolver_wire_10_0, top_convolver_wire_11_0});
xor_n #(2, 0, 0) XOR_5 (top_convolver_wire_12, {top_convolver_wire_13, top_convolver_wire_14_0});
xor_n #(2, 0, 0) XOR_6 (top_convolver_wire_13, {top_convolver_wire_15_0, top_convolver_wire_16_0});
xor_n #(2, 0, 0) XOR_7 (top_convolver_wire_17, {top_convolver_wire_18_0, top_convolver_wire_19_0});
xor_n #(2, 0, 0) XOR_8 (top_convolver_wire_20, {top_convolver_wire_21_0, top_convolver_wire_22_0});
xor_n #(2, 0, 0) XOR_9 (top_convolver_wire_23, {top_convolver_wire_24_0, top_convolver_wire_25_0});
xor_n #(2, 0, 0) XOR_10 (top_convolver_wire_26, {top_convolver_wire_27_0, top_convolver_wire_28_0});
xor_n #(2, 0, 0) XOR_11 (top_convolver_wire_29, {top_convolver_wire_30, top_convolver_wire_31_0});
xor_n #(2, 0, 0) XOR_12 (top_convolver_wire_32, {top_convolver_wire_33_0, top_convolver_wire_34_0});
xor_n #(2, 0, 0) XOR_13 (top_convolver_wire_35, {top_convolver_wire_36, top_convolver_wire_37_0});
xor_n #(2, 0, 0) XOR_14 (top_convolver_wire_38, {top_convolver_wire_39_0, top_convolver_wire_40_0});
xor_n #(2, 0, 0) XOR_15 (top_convolver_wire_41, {top_convolver_wire_42, top_convolver_wire_43_0});
xor_n #(2, 0, 0) XOR_16 (top_convolver_wire_44, {top_convolver_wire_45_0, top_convolver_wire_46_0});
xor_n #(2, 0, 0) XOR_17 (top_convolver_wire_47, {top_convolver_wire_48, top_convolver_wire_49_0});
xor_n #(2, 0, 0) XOR_18 (top_convolver_wire_48, {top_convolver_wire_50_0, top_convolver_wire_51_0});
xor_n #(2, 0, 0) XOR_19 (top_convolver_wire_52, {top_convolver_wire_53, top_convolver_wire_54_0});
xor_n #(2, 0, 0) XOR_20 (top_convolver_wire_53, {top_convolver_wire_55_0, top_convolver_wire_56_0});
and_n #(2, 0, 0) AND_1 (top_convolver_wire_14, {top_convolver_wire_3_1, top_convolver_wire_2_1});
and_n #(2, 0, 0) AND_2 (top_convolver_wire_57, {top_convolver_wire_14_1, top_convolver_wire_58});
and_n #(2, 0, 0) AND_3 (top_convolver_wire_59, {top_convolver_wire_9_1, top_convolver_wire_11_1});
and_n #(2, 0, 0) AND_4 (top_convolver_wire_60, {top_convolver_wire_9_2, top_convolver_wire_10_1});
or_n #(2, 0, 0) OR_1 (top_convolver_wire_9, {top_convolver_wire_61, top_convolver_wire_57});
and_n #(2, 0, 0) AND_5 (top_convolver_wire_61, {top_convolver_wire_15_1, top_convolver_wire_16_1});
or_n #(2, 0, 0) OR_2 (top_convolver_wire_58, {top_convolver_wire_15_2, top_convolver_wire_16_2});
or_n #(3, 0, 0) OR_3 (top_convolver_wire_5, {top_convolver_wire_62, top_convolver_wire_60, top_convolver_wire_59});
and_n #(2, 0, 0) AND_6 (top_convolver_wire_62, {top_convolver_wire_10_2, top_convolver_wire_11_2});
bufg #(0, 0) BUF_1 (top_convolver_wire_63, top_convolver_wire_64);
and_n #(2, 0, 0) AND_7 (top_convolver_wire_64, {top_convolver_wire_19_1, top_convolver_wire_18_1});
bufg #(0, 0) BUF_2 (top_convolver_wire_30, top_convolver_wire_65_0);
and_n #(2, 0, 0) AND_8 (top_convolver_wire_66, {top_convolver_wire_31_1, top_convolver_wire_67});
and_n #(2, 0, 0) AND_9 (top_convolver_wire_31, {top_convolver_wire_27_1, top_convolver_wire_28_1});
bufg #(0, 0) BUF_3 (top_convolver_wire_68, top_convolver_wire_66);
and_n #(2, 0, 0) AND_10 (top_convolver_wire_69, {top_convolver_wire_50_1, top_convolver_wire_51_1});
or_n #(3, 0, 0) OR_4 (top_convolver_wire_70, {top_convolver_wire_69, top_convolver_wire_71, top_convolver_wire_72});
and_n #(2, 0, 0) AND_11 (top_convolver_wire_71, {top_convolver_wire_49_1, top_convolver_wire_50_2});
and_n #(2, 0, 0) AND_12 (top_convolver_wire_72, {top_convolver_wire_49_2, top_convolver_wire_51_2});
and_n #(2, 0, 0) AND_13 (top_convolver_wire_54, {top_convolver_wire_46_1, top_convolver_wire_45_1});
and_n #(2, 0, 0) AND_14 (top_convolver_wire_73, {top_convolver_wire_54_1, top_convolver_wire_74});
or_n #(2, 0, 0) OR_5 (top_convolver_wire_49, {top_convolver_wire_75, top_convolver_wire_73});
and_n #(2, 0, 0) AND_15 (top_convolver_wire_75, {top_convolver_wire_55_1, top_convolver_wire_56_1});
or_n #(2, 0, 0) OR_6 (top_convolver_wire_74, {top_convolver_wire_55_2, top_convolver_wire_56_2});
bufg #(0, 0) BUF_4 (top_convolver_wire_78, top_convolver_wire_79);
and_n #(2, 0, 0) AND_16 (top_convolver_wire_79, {top_convolver_wire_22_1, top_convolver_wire_21_1});
bufg #(0, 0) BUF_5 (top_convolver_wire_36, top_convolver_wire_65_2);
and_n #(2, 0, 0) AND_17 (top_convolver_wire_80, {top_convolver_wire_37_1, top_convolver_wire_81});
and_n #(2, 0, 0) AND_18 (top_convolver_wire_37, {top_convolver_wire_33_1, top_convolver_wire_34_1});
bufg #(0, 0) BUF_6 (top_convolver_wire_82, top_convolver_wire_80);
bufg #(0, 0) BUF_7 (top_convolver_wire_83, top_convolver_wire_84);
and_n #(2, 0, 0) AND_19 (top_convolver_wire_84, {top_convolver_wire_25_1, top_convolver_wire_24_1});
bufg #(0, 0) BUF_8 (top_convolver_wire_42, top_convolver_wire_65_4);
and_n #(2, 0, 0) AND_20 (top_convolver_wire_85, {top_convolver_wire_43_1, top_convolver_wire_86});
and_n #(2, 0, 0) AND_21 (top_convolver_wire_43, {top_convolver_wire_39_1, top_convolver_wire_40_1});
bufg #(0, 0) BUF_9 (top_convolver_wire_87, top_convolver_wire_85);
and_n #(2, 0, 0) AND_22 (top_convolver_wire_89, {top_convolver_wire_118, top_convolver_wire_119_0});
and_n #(2, 0, 0) AND_23 (top_convolver_wire_93, {top_convolver_wire_120, top_convolver_wire_119_1});
and_n #(2, 0, 0) AND_24 (top_convolver_wire_97, {top_convolver_wire_121, top_convolver_wire_119_2});
and_n #(2, 0, 0) AND_25 (top_convolver_wire_90, {top_convolver_wire_122, top_convolver_wire_123_0});
and_n #(2, 0, 0) AND_26 (top_convolver_wire_94, {top_convolver_wire_124, top_convolver_wire_123_1});
and_n #(2, 0, 0) AND_27 (top_convolver_wire_98, {top_convolver_wire_125, top_convolver_wire_123_2});
and_n #(2, 0, 0) AND_28 (top_convolver_wire_91, {top_convolver_wire_126, top_convolver_wire_127_0});
and_n #(2, 0, 0) AND_29 (top_convolver_wire_95, {top_convolver_wire_128, top_convolver_wire_127_1});
and_n #(2, 0, 0) AND_30 (top_convolver_wire_99, {top_convolver_wire_129, top_convolver_wire_127_2});
or_n #(2, 0, 0) OR_7 (top_convolver_wire_116, {top_convolver_wire_101_0, top_convolver_wire_130});
or_n #(2, 0, 0) OR_8 (top_convolver_wire_107, {top_convolver_wire_101_1, top_convolver_wire_131});
and_n #(2, 0, 0) AND_31 (top_convolver_wire_77, {top_convolver_wire_109_0, top_convolver_wire_132});
or_n #(4, 0, 0) OR_9 (top_convolver_wire_133, {top_convolver_wire_109_1, top_convolver_wire_110_0, top_convolver_wire_111_0, top_convolver_wire_112_0});
and_n #(2, 0, 0) AND_32 (top_convolver_wire_100, {top_convolver_wire_110_1, top_convolver_wire_134});
and_n #(2, 0, 0) AND_33 (top_convolver_wire_96, {top_convolver_wire_111_1, top_convolver_wire_135});
and_n #(2, 0, 0) AND_34 (top_convolver_wire_92, {top_convolver_wire_112_1, top_convolver_wire_136});
and_n #(2, 0, 0) AND_35 (top_convolver_wire_88, {top_convolver_wire_113, top_convolver_wire_137});
and_n #(2, 0, 0) AND_36 (top_convolver_wire_114, {top_convolver_wire_117_0, top_convolver_wire_138_0});
and_n #(2, 0, 0) AND_37 (top_convolver_wire_130, {top_convolver_wire_117_1, top_convolver_wire_139});
notg #(0, 0) NOT_1 (top_convolver_wire_139, top_convolver_wire_138_1);
bufg #(0, 0) BUF_10 (top_convolver_wire_65, 1'b0);
notg #(0, 0) NOT_2 (top_convolver_wire_137, top_convolver_wire_102_0);
notg #(0, 0) NOT_3 (top_convolver_wire_136, top_convolver_wire_102_1);
notg #(0, 0) NOT_4 (top_convolver_wire_135, top_convolver_wire_102_2);
notg #(0, 0) NOT_5 (top_convolver_wire_134, top_convolver_wire_102_3);
notg #(0, 0) NOT_6 (top_convolver_wire_132, top_convolver_wire_102_4);
and_n #(2, 0, 0) AND_38 (top_convolver_wire_131, {top_convolver_wire_108_0, top_convolver_wire_133});
bufg #(0, 0) BUF_11 (top_convolver_wire_76, clk_net_0);
bufg #(0, 0) BUF_12 (top_convolver_wire_118, coeff_11_net_0);
bufg #(0, 0) BUF_13 (top_convolver_wire_120, coeff_12_net_0);
bufg #(0, 0) BUF_14 (top_convolver_wire_121, coeff_13_net_0);
bufg #(0, 0) BUF_15 (top_convolver_wire_122, coeff_21_net_0);
bufg #(0, 0) BUF_16 (top_convolver_wire_124, coeff_22_net_0);
bufg #(0, 0) BUF_17 (top_convolver_wire_125, coeff_23_net_0);
bufg #(0, 0) BUF_18 (top_convolver_wire_126, coeff_31_net_0);
bufg #(0, 0) BUF_19 (top_convolver_wire_128, coeff_32_net_0);
bufg #(0, 0) BUF_20 (top_convolver_wire_129, coeff_33_net_0);
bufg #(0, 0) BUF_21 (conv_result_3, top_convolver_wire_106);
bufg #(0, 0) BUF_22 (conv_result_2, top_convolver_wire_105);
bufg #(0, 0) BUF_23 (conv_result_1, top_convolver_wire_104);
bufg #(0, 0) BUF_24 (conv_result_0, top_convolver_wire_103);
bufg #(0, 0) BUF_25 (top_convolver_wire_119, pixel_1_net_0);
bufg #(0, 0) BUF_26 (top_convolver_wire_123, pixel_2_net_0);
bufg #(0, 0) BUF_27 (top_convolver_wire_127, pixel_3_net_0);
bufg #(0, 0) BUF_28 (top_convolver_wire_102, rst_net_0);
bufg #(0, 0) BUF_29 (top_convolver_wire_138, valid_in_net_0);
bufg #(0, 0) BUF_30 (valid_out_net_0, top_convolver_wire_108_1);

//1st Chain
dff DFF_1  (top_convolver_wire_6, top_convolver_wire_70, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_77, NbarT, Si1, 1'b0);
dff DFF_2  (top_convolver_wire_19, top_convolver_wire_89, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_88, NbarT, top_convolver_wire_6, 1'b0);
dff DFF_3  (top_convolver_wire_22, top_convolver_wire_90, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_88, NbarT, top_convolver_wire_19, 1'b0);
dff DFF_4  (top_convolver_wire_25, top_convolver_wire_91, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_88, NbarT, top_convolver_wire_22, 1'b0);
dff DFF_5  (top_convolver_wire_18, top_convolver_wire_93, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_92, NbarT, top_convolver_wire_25, 1'b0);
dff DFF_6  (top_convolver_wire_21, top_convolver_wire_94, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_92, NbarT, top_convolver_wire_18, 1'b0);
dff DFF_7  (top_convolver_wire_24, top_convolver_wire_95, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_92, NbarT, top_convolver_wire_21, 1'b0);
dff DFF_8  (top_convolver_wire_27, top_convolver_wire_97, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_96, NbarT, top_convolver_wire_24, 1'b0);
dff DFF_9  (top_convolver_wire_33, top_convolver_wire_98, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_96, NbarT, top_convolver_wire_27, 1'b0);
dff DFF_10  (top_convolver_wire_39, top_convolver_wire_99, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_96, NbarT, top_convolver_wire_33, 1'b0);
dff DFF_11  (top_convolver_wire_67, top_convolver_wire_63, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_96, NbarT, top_convolver_wire_39, 1'b0);
dff DFF_12  (top_convolver_wire_28, top_convolver_wire_17, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_96, NbarT, top_convolver_wire_67, 1'b0);
dff DFF_13  (top_convolver_wire_81, top_convolver_wire_78, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_96, NbarT, top_convolver_wire_28, 1'b0);
//2nd Chain
dff DFF_14  (top_convolver_wire_34, top_convolver_wire_20, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_96, NbarT, Si2, 1'b0);
dff DFF_15  (top_convolver_wire_86, top_convolver_wire_83, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_96, NbarT, top_convolver_wire_34, 1'b0);
dff DFF_16  (top_convolver_wire_40, top_convolver_wire_23, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_96, NbarT, top_convolver_wire_86, 1'b0);
dff DFF_17  (top_convolver_wire_50, top_convolver_wire_68, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_100, NbarT, top_convolver_wire_40, 1'b0);
dff DFF_18  (top_convolver_wire_55, top_convolver_wire_29, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_100, NbarT, top_convolver_wire_50, 1'b0);
dff DFF_19  (top_convolver_wire_46, top_convolver_wire_26, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_100, NbarT, top_convolver_wire_55, 1'b0);
dff DFF_20  (top_convolver_wire_51, top_convolver_wire_82, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_100, NbarT, top_convolver_wire_46, 1'b0);
dff DFF_21  (top_convolver_wire_56, top_convolver_wire_35, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_100, NbarT, top_convolver_wire_51, 1'b0);
dff DFF_22  (top_convolver_wire_45, top_convolver_wire_32, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_100, NbarT, top_convolver_wire_56, 1'b0);
dff DFF_23  (top_convolver_wire_11, top_convolver_wire_87, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_100, NbarT, top_convolver_wire_45, 1'b0);
dff DFF_24  (top_convolver_wire_16, top_convolver_wire_41, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_100, NbarT, top_convolver_wire_11, 1'b0);
dff DFF_25  (top_convolver_wire_2, top_convolver_wire_38, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_100, NbarT, top_convolver_wire_16, 1'b0);
dff DFF_26  (top_convolver_wire_10, top_convolver_wire_47, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_77, NbarT, top_convolver_wire_2, 1'b0);
//3rd Chain
dff DFF_27  (top_convolver_wire_15, top_convolver_wire_52, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_77, NbarT, Si3, 1'b0);
dff DFF_28  (top_convolver_wire_3, top_convolver_wire_44, top_convolver_wire_76, top_convolver_wire_65, 1'b0, top_convolver_wire_77, NbarT, top_convolver_wire_15, 1'b0);
dff DFF_29  (top_convolver_wire_103, top_convolver_wire_4, top_convolver_wire_76, top_convolver_wire_102, 1'b0, top_convolver_wire_101, NbarT, top_convolver_wire_3, 1'b0);
dff DFF_30  (top_convolver_wire_104, top_convolver_wire_7, top_convolver_wire_76, top_convolver_wire_102, 1'b0, top_convolver_wire_101, NbarT, top_convolver_wire_103, 1'b0);
dff DFF_31  (top_convolver_wire_105, top_convolver_wire_12, top_convolver_wire_76, top_convolver_wire_102, 1'b0, top_convolver_wire_101, NbarT, top_convolver_wire_104, 1'b0);
dff DFF_32  (top_convolver_wire_106, top_convolver_wire_1, top_convolver_wire_76, top_convolver_wire_102, 1'b0, top_convolver_wire_101, NbarT, top_convolver_wire_105, 1'b0);
dff DFF_33  (top_convolver_wire_108, top_convolver_wire_107, top_convolver_wire_76, top_convolver_wire_102, 1'b0, 1'b1, NbarT, top_convolver_wire_106, 1'b0);
dff DFF_34  (top_convolver_wire_101, top_convolver_wire_109, top_convolver_wire_76, top_convolver_wire_102, 1'b0, 1'b1, NbarT, top_convolver_wire_108, 1'b0);
dff DFF_35  (top_convolver_wire_109, top_convolver_wire_110, top_convolver_wire_76, top_convolver_wire_102, 1'b0, 1'b1, NbarT, top_convolver_wire_101, 1'b0);
dff DFF_36  (top_convolver_wire_110, top_convolver_wire_111, top_convolver_wire_76, top_convolver_wire_102, 1'b0, 1'b1, NbarT, top_convolver_wire_109, 1'b0);
dff DFF_37  (top_convolver_wire_111, top_convolver_wire_112, top_convolver_wire_76, top_convolver_wire_102, 1'b0, 1'b1, NbarT, top_convolver_wire_110, 1'b0);
dff DFF_38  (top_convolver_wire_112, top_convolver_wire_113, top_convolver_wire_76, top_convolver_wire_102, 1'b0, 1'b1, NbarT, top_convolver_wire_111, 1'b0);
dff DFF_39  (top_convolver_wire_113, top_convolver_wire_114, top_convolver_wire_76, top_convolver_wire_102, 1'b0, 1'b1, NbarT, top_convolver_wire_112, 1'b0);
dff DFF_40  (top_convolver_wire_117, top_convolver_wire_116, top_convolver_wire_76, top_convolver_wire_115, top_convolver_wire_102, 1'b1, NbarT, top_convolver_wire_113, 1'b0);

assign So1 = top_convolver_wire_81;
assign So2 = top_convolver_wire_10;
assign So3 = top_convolver_wire_117;
endmodule
