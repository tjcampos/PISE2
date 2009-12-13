module AUDIO_ADC(
	// host
	clk,
	reset,
	read,
	readdata,
	//available,
	empty,
	clear,
	// dac
	bclk,
	adclrc,
	adcdat
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/
parameter	DATA_WIDTH = 32;

/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
input							clk;
input							reset;
input							read;
output	[(DATA_WIDTH-1):0]		readdata;
//output	[((DATA_WIDTH/2)-1):0]	available;
output							empty;
input							clear;

input							bclk;
input							adclrc;
input							adcdat;

/*****************************************************************************
 *                           Constant Declarations                           *
 *****************************************************************************/


/*****************************************************************************
 *                 Internal wires and registers Declarations                 *
 *****************************************************************************/

reg		[7:0]					bit_index; 
reg								valid_bit;
reg								reg_adc_left;
reg		[(DATA_WIDTH-1):0]		reg_adc_serial_data;

reg		[(DATA_WIDTH-1):0]		adcfifo_writedata;
reg								adcfifo_write;
wire							adcfifo_full;

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential logic                              *
 *****************************************************************************/

//===== Serail data to ADC FIFO =====
always @ (posedge bclk) 
    begin
        if (reset || clear)
            begin
                bit_index = 0;
                reg_adc_left = adclrc;
                adcfifo_write = 1'b0;
            end
        else
            begin
                if (adcfifo_write)
                    adcfifo_write = 1'b0;  // disable write at second cycle
        
                if (reg_adc_left ^ adclrc)
                    begin		// channel change
                        reg_adc_left = adclrc;
                        valid_bit = (reg_adc_left || (bit_index == (DATA_WIDTH/2)))?1:0;
                        if (reg_adc_left)
                            bit_index = DATA_WIDTH;
                    end
        
                // serial bit to adcfifo
                if (valid_bit)  
                    begin
                        bit_index = bit_index - 1;
                        reg_adc_serial_data[bit_index] = adcdat;
                        if ((bit_index == 0) || (bit_index == (DATA_WIDTH/2)))
                            begin	// write data to adcfifo
                                if (bit_index == 0)
                                    begin
                                        adcfifo_writedata = reg_adc_serial_data;
                                        adcfifo_write = 1'b1;  // enable write at first cycle
                                    end
                                valid_bit = 0;
                            end
                    end			
                //===== read data from ADC FIFO =====
            end
    end

/*****************************************************************************
 *                            Combinational logic                            *
 *****************************************************************************/


/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

audio_fifo adc_fifo(
	.aclr(clear),
	// write (adc write to fifo)
	.wrclk(bclk),
	.wrreq(adcfifo_write),
	.data(adcfifo_writedata),
	.wrfull(adcfifo_full),
	// read (host read from fifo)
	.rdclk(clk),
	.rdreq(read),
	.q(readdata),
	//.rdusedw(adcfifo_available),
	.rdempty(empty)
);	


endmodule

