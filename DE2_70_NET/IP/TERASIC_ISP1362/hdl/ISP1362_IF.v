module ISP1362_IF(	//	avalon MM slave port, ISP1362, host control
					// avalon MM slave, hc interface to nios
					avs_hc_writedata_iDATA,
					avs_hc_readdata_oDATA,
					avs_hc_address_iADDR,
					avs_hc_read_n_iRD_N,
					avs_hc_write_n_iWR_N,
					avs_hc_chipselect_n_iCS_N,
					avs_hc_reset_n_iRST_N,
					avs_hc_clk_iCLK,
					avs_hc_irq_n_oINT0_N,
					// avalon MM slave, dcc interface to nios
					avs_dc_writedata_iDATA,
					avs_dc_readdata_oDATA,
					avs_dc_address_iADDR,
					avs_dc_read_n_iRD_N,
					avs_dc_write_n_iWR_N,
					avs_dc_chipselect_n_iCS_N,
					avs_dc_reset_n_iRST_N,
					avs_dc_clk_iCLK,
					avs_dc_irq_n_oINT0_N,
					//	ISP1362 Side
					avs_hc_export_OTG_DATA,
					avs_hc_export_OTG_ADDR,
					avs_hc_export_OTG_RD_N,
					avs_hc_export_OTG_WR_N,
					avs_hc_export_OTG_CS_N,
					avs_hc_export_OTG_RST_N,
					avs_hc_export_OTG_INT0,
					avs_dc_export_OTG_INT1
				 );
//	to nios
// slave hc
input	[15:0]	avs_hc_writedata_iDATA;
input	 		avs_hc_address_iADDR;
input			avs_hc_read_n_iRD_N;
input			avs_hc_write_n_iWR_N;
input			avs_hc_chipselect_n_iCS_N;
input			avs_hc_reset_n_iRST_N;
input			avs_hc_clk_iCLK;
output	[15:0]	avs_hc_readdata_oDATA;
output			avs_hc_irq_n_oINT0_N;
// slave dc
input	[15:0]	avs_dc_writedata_iDATA;
input			avs_dc_address_iADDR;
input			avs_dc_read_n_iRD_N;
input			avs_dc_write_n_iWR_N;
input			avs_dc_chipselect_n_iCS_N;
input			avs_dc_reset_n_iRST_N;
input			avs_dc_clk_iCLK;
output	[15:0]	avs_dc_readdata_oDATA;
output			avs_dc_irq_n_oINT0_N;



//	ISP1362 Side
inout	[15:0]	avs_hc_export_OTG_DATA;
output	[1:0]	avs_hc_export_OTG_ADDR;
output			avs_hc_export_OTG_RD_N;
output			avs_hc_export_OTG_WR_N;
output			avs_hc_export_OTG_CS_N;
output			avs_hc_export_OTG_RST_N;
input			avs_hc_export_OTG_INT0;
input			avs_dc_export_OTG_INT1;





assign	avs_hc_export_OTG_DATA		=	avs_dc_chipselect_n_iCS_N ? (avs_hc_write_n_iWR_N	?	16'hzzzz	:	avs_hc_writedata_iDATA) :  (avs_dc_write_n_iWR_N	?	16'hzzzz	:	avs_dc_writedata_iDATA) ;
assign	avs_hc_readdata_oDATA		=	avs_hc_read_n_iRD_N	?	16'hzzzz	:	avs_hc_export_OTG_DATA;
assign	avs_dc_readdata_oDATA		=	avs_dc_read_n_iRD_N	?	16'hzzzz	:	avs_hc_export_OTG_DATA;
assign	avs_hc_export_OTG_ADDR		=	avs_dc_chipselect_n_iCS_N? {1'b0,avs_hc_address_iADDR} : {1'b1,avs_dc_address_iADDR};
assign	avs_hc_export_OTG_CS_N		=	avs_hc_chipselect_n_iCS_N & avs_dc_chipselect_n_iCS_N;
assign	avs_hc_export_OTG_WR_N		=	avs_dc_chipselect_n_iCS_N? avs_hc_write_n_iWR_N : avs_dc_write_n_iWR_N;
assign	avs_hc_export_OTG_RD_N		=	avs_dc_chipselect_n_iCS_N? avs_hc_read_n_iRD_N  : avs_dc_read_n_iRD_N;
assign	avs_hc_export_OTG_RST_N		=	avs_dc_chipselect_n_iCS_N? avs_hc_reset_n_iRST_N: avs_dc_reset_n_iRST_N;
assign	avs_hc_irq_n_oINT0_N		=	avs_hc_export_OTG_INT0;
assign	avs_dc_irq_n_oINT0_N		=	avs_dc_export_OTG_INT1;




endmodule