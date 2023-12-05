
from migen import *
from migen.genlib.cdc import MultiReg
from litex.soc.interconnect.csr import *
from litex.soc.interconnect.csr_eventmanager import *



class Verilog_I2S(Module,AutoCSR):
    def __init__(self, data):
    
    # Interfaz
        
        self.clk = ClockSignal()
        self.rst = ResetSignal()
        self.sck = data.sck
        self.sd  = data.sd
        self.ws  = data.ws

    # Registros Lectura
        
        self.busy = CSRStatus()

    # Registros Escritura
        
        self.dta = CSRStorage(16)
        self.init = CSRStorage()

    # Instanciacion del modulo verilog

        self.specials += Instance("i2s",
            i_clk  = self.clk,
            i_rst  = self.rst,
            o_sck  = self.sck,
            o_ws   = self.ws,
            o_sd   = self.sd,
            i_dta  = self.dta.storage,
			i_init = self.init.storage,
            o_busy = self.busy.status
            )

        self.submodules.ev = EventManager()
        self.ev.ok = EventSourceProcess()
        self.ev.finalize()

