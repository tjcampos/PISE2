# generated_app.mk
#
# Machine generated for a CPU named "cpu" as defined in:
# /home/tjcampos/tmp2/DE2_70_NET/DE2_70_SOPC.ptf
#
# Generated: 2009-12-12 15:57:55.841

# DO NOT MODIFY THIS FILE
#
#   Changing this file will have subtle consequences
#   which will almost certainly lead to a nonfunctioning
#   system. If you do modify this file, be aware that your
#   changes will be overwritten and lost when this file
#   is generated again.
#
# DO NOT MODIFY THIS FILE

# assuming the Quartus project directory is the same as the PTF directory
QUARTUS_PROJECT_DIR = /home/tjcampos/tmp2/DE2_70_NET

# the simulation directory is a subdirectory of the PTF directory
SIMDIR = $(QUARTUS_PROJECT_DIR)/DE2_70_SOPC_sim

DBL_QUOTE := "


# macros defined by/for cfi_flash
CFI_FLASH_FLASHTARGET_ALT_SIM_PREFIX = $(CFI_FLASH_FLASHTARGET_TMP1:0=)
CFI_FLASH_FLASHTARGET_TMP1 = $(ALT_SIM_OPTIMIZE:1=RUN_ON_HDL_SIMULATOR_ONLY_)
BOOT_COPIER = boot_loader_cfi.srec
CPU_CLASS = altera_nios2
CPU_RESET_ADDRESS = 0x9620000


all: delete_placeholder_warning hex sim flashfiles

delete_placeholder_warning: do_delete_placeholder_warning
.PHONY: delete_placeholder_warning

hex: $(QUARTUS_PROJECT_DIR)/onchip_mem.hex
.PHONY: hex

sim: $(SIMDIR)/dummy_file
.PHONY: sim

flashfiles: $(CFI_FLASH_FLASHTARGET_ALT_SIM_PREFIX)cfi_flash.flash
.PHONY: flashfiles

verifysysid: dummy_verifysysid_file
.PHONY: verifysysid

do_delete_placeholder_warning:
	rm -f $(SIMDIR)/contents_file_warning.txt
.PHONY: do_delete_placeholder_warning

$(QUARTUS_PROJECT_DIR)/onchip_mem.hex: $(ELF)
	@echo Post-processing to create $(notdir $@)
	elf2hex $(ELF) 0x09620000 0x9621FFF --width=32 $(QUARTUS_PROJECT_DIR)/onchip_mem.hex --create-lanes=0

$(SIMDIR)/dummy_file: $(ELF)
	if [ ! -d $(SIMDIR) ]; then mkdir $(SIMDIR) ; fi
	@echo Hardware simulation is not enabled for the target SOPC Builder system. Skipping creation of hardware simulation model contents and simulation symbol files. \(Note: This does not affect the instruction set simulator.\)
	touch $(SIMDIR)/dummy_file

$(CFI_FLASH_FLASHTARGET_ALT_SIM_PREFIX)cfi_flash.flash: $(ELF)
	@echo Post-processing to create $(notdir $@)
	elf2flash --input=$(ELF) --flash= --boot=$(DBL_QUOTE)$(shell $(DBL_QUOTE)$(QUARTUS_ROOTDIR)/sopc_builder/bin/find_sopc_component_dir$(DBL_QUOTE) $(CPU_CLASS) $(QUARTUS_PROJECT_DIR))/$(BOOT_COPIER)$(DBL_QUOTE) --outfile=$(CFI_FLASH_FLASHTARGET_ALT_SIM_PREFIX)cfi_flash.flash --sim_optimize=$(ALT_SIM_OPTIMIZE) --base=0x8800000 --end=0x8FFFFFF --reset=$(CPU_RESET_ADDRESS)

dummy_verifysysid_file:
	nios2-download $(JTAG_CABLE)                                --sidp=0x096411d0 --id=1520569647 --timestamp=1195523523
.PHONY: dummy_verifysysid_file


generated_app_clean:
	$(RM) $(QUARTUS_PROJECT_DIR)/onchip_mem.hex
	$(RM) $(SIMDIR)/dummy_file
	$(RM) $(CFI_FLASH_FLASHTARGET_ALT_SIM_PREFIX)cfi_flash.flash
.PHONY: generated_app_clean
