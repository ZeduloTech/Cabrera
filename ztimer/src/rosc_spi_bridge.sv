// rosc_spi_bridge

module rosc_spi_bridge #(
    parameter integer FLAT_COUNTER_REGISTERS = 96,
    parameter integer N = 3
)(
    input wire clk_i,
    input wire rst_ni,
    
    input wire cio_sck_i,
    input wire cio_csb_i,
    input wire cio_sd_i,
    output wire cio_sd_o,

    input  wire rosc_enable_i,
    input wire start_i,
    input  wire stop_i
);	 

    wire [31:0] t0_elapsed_time;
    wire [31:0] t1_elapsed_time;
    wire [31:0] t2_elapsed_time;
	 

    wire [FLAT_COUNTER_REGISTERS - 1:0] counters_i;
    wire [3:0]  cnt_idx;
    wire      cnt_rst_en;
	 
	 
    assign counters_i[0 * 32 +: 32] = t0_elapsed_time;
    assign counters_i[1 * 32 +: 32] = t1_elapsed_time;
    assign counters_i[2 * 32 +: 32] = t2_elapsed_time;


    rosc_timer #(.N(N)) u_timer0 (
        .rst_n         (rst_ni),
        .rosc_enable   (rosc_enable_i),
        .clear         (cnt_rst_en && (cnt_idx == 4'd0)),
        .start         (start_i),
        .stop          (stop_i),
        .elapsed_count (t0_elapsed_time)
    );
    
    rosc_timer #(.N(5)) u_timer1 (
        .rst_n         (rst_ni),
        .rosc_enable   (rosc_enable_i),
        .clear         (cnt_rst_en && (cnt_idx == 4'd1)),
        .start         (start_i),
        .stop          (stop_i),
        .elapsed_count (t1_elapsed_time)
    );

	 clk_timer u_timer2 (
		  .clk_i         (clk_i),
		  .rst_n         (rst_ni),
		  .clear         (cnt_rst_en && (cnt_idx == 4'd2)),
		  .start         (start_i),
		  .stop          (stop_i),
		  .elapsed_count (t2_elapsed_time)
	);
   
    spi_device s_device (
        .clk_i      (clk_i),
        .rst_ni     (rst_ni),

        .cio_sck_i  (cio_sck_i),
        .cio_csb_i  (cio_csb_i),
        .cio_sd_i   (cio_sd_i),
        .cio_sd_o   (cio_sd_o),

        .counters_i (counters_i),
        .cnt_idx    (cnt_idx),
        .cnt_rst_en (cnt_rst_en)
    );

endmodule
