module AUDIO_DAC(
	// host
	clk,
	reset,
	write,
	writedata,
	full,
	clear,
	// dac
	bclk,
	daclrc,
	dacdat
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/
parameter	DATA_WIDTH = 32;

/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
input						clk;
input						reset;
input						write;
input	[(DATA_WIDTH-1):0]	writedata;
output						full;
input						clear;

input						bclk;
input						daclrc;
output						dacdat;


/*****************************************************************************
 *                           Constant Declarations                           *
 *****************************************************************************/


/*****************************************************************************
 *                 Internal wires and registers Declarations                 *
 *****************************************************************************/

// Note. Left Justified Mode
reg							request_bit;
reg							bit_to_dac;
reg		[7:0]				bit_index;
reg							dac_is_left;
reg		[(DATA_WIDTH-1):0]	data_to_dac;		
reg		[(DATA_WIDTH-1):0]	shift_data_to_dac;	

//
wire						dacfifo_empty;
reg 						dacfifo_read;
wire	[(DATA_WIDTH-1):0]	dacfifo_readdata;

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential logic                              *
 *****************************************************************************/
always @ (posedge bclk) 
    begin
        if (reset || clear)
            begin
                request_bit = 0;
                bit_index = 0;
                dac_is_left = daclrc;
                bit_to_dac = 1'b0;
            end
        else
            begin
                if (dac_is_left ^ daclrc)
                    begin		// channel change
                        dac_is_left = daclrc;
                        request_bit = (dac_is_left || (bit_index == (DATA_WIDTH/2)))?1:0;
                        if (dac_is_left)
                            begin
                                // init
                                shift_data_to_dac = data_to_dac;
                                dacfifo_read = 1;
                                bit_index = DATA_WIDTH;
                                // get sample from adc-fifo (used in next sample serialize)
                            end
                    end
                
                // get sample from dac-fifo (used in next sample serial)
                if (bit_index == (DATA_WIDTH-1))
                    begin
                        data_to_dac = (dacfifo_empty)?0:(dacfifo_readdata);
                        dacfifo_read = 0;
                    end
                    
                // serial data to dac		
                if (request_bit)
                    begin
                        bit_index = bit_index - 1;
                        bit_to_dac = shift_data_to_dac[bit_index];  // MSB as first bit
                        if ((bit_index == 0) || (bit_index == (DATA_WIDTH/2)))
                            request_bit = 0;
                    end			
                else
                    bit_to_dac = 1'b0;
            end
    end


/*****************************************************************************
 *                            Combinational logic                            *
 *****************************************************************************/

assign	dacdat = bit_to_dac;

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

audio_fifo dac_fifo(
	// control
	.aclr(clear),
	// write
	.wrclk(clk),
	.wrreq(write),
	.data(writedata),
	.wrfull(full),
	// read
	.rdclk(bclk),
	.rdreq(dacfifo_read),
	.q(dacfifo_readdata),
	.rdempty(dacfifo_empty),
);

endmodule



