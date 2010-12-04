---
author: Brandon Stafford
categories: atmel, jtag
date: 2010/07/07 15:22:00
draft: True
format: markdown
title: Loading code onto the AT91SAM9G20
---

Atmel provides a tool for loading code onto their SAM series of microcontrollers, called SAM-BA, for SAM Boot Assistant. It has nothing to do with the SMB/CIFS implementation called Samba. The official release is built for Windows XP, but Atmel also provides a build for [Linux][1].

The Linux build requires Tcl 8.4, TclX 8.4 and Tk 8.4, which can be installed on Ubuntu with this:

$$code(lang=bash)
    sudo apt-get install tcl8.4 tclx8.4 tk8.5
$$/code

Check whether the usbserial module is already running in the kernel.

lsmod will tell you whether it's already running.

You should get back a long list like this:

$$code(lang=text)
    fbcon                  35102  71 
    tileblit                2031  1 fbcon
    font                    7557  1 fbcon
    bitblit                 4707  1 fbcon
    softcursor              1189  1 bitblit
    dell_wmi                1793  0 
    dcdbas                  5422  0 
    lp                      7028  0 
    nvidia               9961216  38 
    vga16fb                11385  1 
    vgastate                8961  1 vga16fb
    psmouse                63245  0 
    soundcore               6620  1 snd
    serio_raw               3978  0 
    snd_page_alloc          7076  2 snd_hda_intel,snd_pcm
    parport                32635  2 ppdev,lp
    intel_agp              24119  0 
    agpgart                31724  2 nvidia,intel_agp
    usbhid                 36110  0 
    hid                    67032  1 usbhid
    ahci                   32168  3 
    e1000e                119824  0 
$$/code

The first number in each row is the size of the driver. The second is the number of other drivers depending on it. The last column is a list of the dependent drivers.

$$code(lang=bash)
    lsmod | grep usbserial
$$/code

If it is, you'll see something like this:

$$code(lang=text)
    usbserial              33019  0
$$/code

$$code(lang=bash)
    sudo modprobe usbserial vendor=0x03eb product=0x6124
$$/code

You should see something like this in dmesg:

$$code(lang=text)
    [77822.106146] usbcore: registered new interface driver usbserial
    [77822.106158] USB Serial support registered for generic
    [77822.106175] usbcore: registered new interface driver usbserial_generic
    [77822.106176] usbserial: USB Serial Driver core
$$/code

When you plug in the SAM-ICE, you'll see this appear at the end of dmesg:
$$code(lang=text)
    [78308.352045] usb 4-2: new full speed USB device using uhci_hcd and address 2
    [78308.538170] usb 4-2: configuration #1 chosen from 1 choice
$$/code

Then this appears in the output of lsusb
    Bus 004 Device 004: ID 1366:0101

Unfortunately, you will then be stuck and try writing a udev rules file in /etc/udev/rules.d with this in it:

    BUS!="usb", ACTION!="add", SUBSYSTEM!=="usb_device", GOTO="kcontrol_rules_end"

    SYSFS{idProduct}=="0x6124", SYSFS{idVendor}=="0x03EB", MODE="664", GROUP="plugdev"
    LABEL="kcontrol_rules_end"

Yes, the plugdev group exists, and I'm a member of it.

    brandon@milo:~/Desktop/Dropbox/Rascal Micro/Software/Tools/JLinkSoftware_100618$ ./start 
    ./JLinkExe: error while loading shared libraries: libjlinkarm.so.0: cannot open shared object file: No such file or directory
    brandon@milo:~/Desktop/Dropbox/Rascal Micro/Software/Tools/JLinkSoftware_100618$ cp libjlinkarm.so.0.0 libjlinkarm.so.0
    brandon@milo:~/Desktop/Dropbox/Rascal Micro/Software/Tools/JLinkSoftware_100618$ ./start 
    SEGGER J-Link Commander V4.15b ('?' for help)
    Compiled Jun 16 2010 14:35:58
    Updating firmware:  J-Link ARM V8 compiled Dec  1 2009 11:42:48
    Replacing firmware: J-Link ARM V8 compiled Mar 27 2009 16:41:15
    Waiting for new firmware to boot
    New firmware booted successfully

    ****** Error: USB communication timed out: Requested 1 bytes, received 0 bytes !
    Communication timed out: Requested 1 bytes, received -19 bytes !
    Communication timed out - Can not execute firmware update
    DLL version V4.15b, compiled Jun 16 2010 14:32:52
    Unable to retrieve firmware info !
    S/N : -3 
    Segmentation fault
    brandon@milo:~/Desktop/Dropbox/Rascal Micro/Software/Tools/JLinkSoftware_100618$ lsusb
    Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
    Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
    Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
    Bus 004 Device 003: ID 1366:0101  
    Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
    Bus 003 Device 003: ID 413c:2005 Dell Computer Corp. RT7D50 Keyboard
    Bus 003 Device 002: ID 046d:c016 Logitech, Inc. M-UV69a/HP M-UV96 Optical Wheel Mouse
    Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
    Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
    Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
    brandon@milo:~/Desktop/Dropbox/Rascal Micro/Software/Tools/JLinkSoftware_100618$ ./start 
    SEGGER J-Link Commander V4.15b ('?' for help)
    Compiled Jun 16 2010 14:35:58
    Updating firmware:  J-Link ARM V8 compiled Dec  1 2009 11:42:48
    Replacing firmware: J-Link ARM V8 compiled Feb 27 2009 BTL     
      ... Firmware update successful. CRC=0FC3
    Waiting for new firmware to boot
    Segmentation fault
    brandon@milo:~/Desktop/Dropbox/Rascal Micro/Software/Tools/JLinkSoftware_100618$ ./start 
    SEGGER J-Link Commander V4.15b ('?' for help)
    Compiled Jun 16 2010 14:35:58
    DLL version V4.15b, compiled Jun 16 2010 14:32:52
    Firmware: J-Link ARM V8 compiled Dec  1 2009 11:42:48
    Hardware: V8.00
    S/N : 28004477 
    OEM : SAM-ICE 
    Feature(s) : RDI 
    VTarget = 0.000V
    J-Link>help
    Unknown command. '?' for help.
    J-Link>?

    Available commands are:
    ----------------------
    f          Firmware info
    h          halt
    g          go
    Sleep      Waits the given time (in milliseconds). Syntax: Sleep <delay>
    s          Single step the target chip
    st         Show hardware status
    hwinfo     Show hardware info
    mem        Read memory.           Syntax: mem  <Addr>, <NumBytes> (hex)
    w1         Write  8-bit items. Syntax: w1 <Addr>, <Data> (hex)
    w2         Write 16-bit items. Syntax: w2 <Addr>, <Data> (hex)
    w4         Write 32-bit items. Syntax: w4 <Addr>, <Data> (hex)
    wm         Write test words. Syntax: wm <NumWords>
    is         Identify length of scan chain select register
    ms         Measure length of scan chain. Syntax: ms <Scan chain>
    mr         Measure RTCK react time. Syntax: mr
    q          Quit
    qc         Close JLink connection and quit
    r          Reset target         (RESET)
    rx         Reset target         (RESET). Syntax: rx <DelayAfterReset>
    RSetType   Set the current reset type. Syntax: RSetType <type>
    Regs       Display contents of registers
    wreg       Write register.   Syntax: wreg <RegName>, <Value>
    SetBP      Set breakpoint.   Syntax: SetBP <addr> [A/T] [S/H]
    SetWP      Set Watchpoint. Syntax: <Addr> [R/W] [<Data> [<D-Mask>] [A-Mask]]
    ClrBP      Clear breakpoint. Syntax: ClrBP  <BP_Handle>
    ClrWP      Clear watchpoint. Syntax: ClrWP  <WP_Handle>
    VCatch     Write vector catch. Syntax: VCatch <Value>
    loadbin    Load binary file into target memory.
                 Syntax: loadbin <filename>, <addr>
    SetPC      Set the PC to specified value. Syntax: SetPC <Addr>
    le         Change to little endian mode
    be         Change to big endian mode
    log        Enables log to file.  Syntax: log <filename>
    unlock     Unlocks a device. Syntax: unlock <DeviceName>
               Type unlock without <DeviceName> to get a list
               of supported device names.
               nRESET has to be connected
    ---- CP15 ------------
    rce        Read CP15.  Syntax: rce <Op1>, <CRn>, <CRm>, <Op2>
    wce        Write CP15. Syntax: wce <Op1>, <CRn>, <CRm>, <Op2>, <Data>
    ---- ICE -------------
    Ice        Show state of the embedded ice macrocell (ICE breaker)
    ri         Read Ice reg.  Syntax: ri <RegIndex>(hex)
    wi         Write Ice reg. Syntax: wi <RegIndex>, <Data>(hex)
    ---- ETM -------------
    etm        Show ETM status
    re         Read ETM reg.  Syntax: re <RegIndex>
    we         Write ETM reg. Syntax: we <RegIndex>, <Data>(hex)
    es         Start trace
    ---- ETB -------------
    etb        Show ETB status
    rb         Read ETB register.  Syntax: rb <RegIndex>
    wb         Write ETB register. Syntax: wb <RegIndex>, <Data>(hex)
    ---- TRACE -----------
    TAddBranch TRACE - Add branch instruction to trace buffer. Paras:<Addr>,<BAddr>
    TAddInst   TRACE - Add (non-branch) instruction to trace buffer. Syntax: <Addr>
    TClear     TRACE - Clear buffer
    TSetSize   TRACE - Set Size of trace buffer
    TSetFormat TRACE - SetFormat
    TSR        TRACE - Show Regions (and analyze trace buffer)
    TStart     TRACE - Start
    TStop      TRACE - Stop
    ---- SWO -------------
    SWOSpeed   SWO - Show supported speeds
    SWOStart   SWO - Start
    SWOStop    SWO - Stop
    SWOStat    SWO - Display SWO status
    SWORead    SWO - Read and display SWO data
    SWOShow    SWO - Read and analyze SWO data
    SWOFlush   SWO - Flush data
    ---- File I/O --------
    fwrite     Write file to emulator
    fread      Read file from emulator
    fshow      Read and display file from emulator
    fdelete    Delete file on emulator
    fsize      Display size of file on emulator
    ---- Test ------------
    thg        Run go/halt 1000 times
    ts         Run step 1000 times
    testwspeed Test download speed.   Syntax: testwspeed [<Addr> [<Size>]]
    testrspeed Test upload speed.     Syntax: testrspeed [<Addr> [<Size>] [<NumBlocks>]]
    testcspeed Test CPU speed.        Syntax: testcspeed [<RAMAddr>]
    ---- JTAG ------------
    Config     Set number of IR/DR bits before ARM device.
                 Syntax: Config <IRpre>, <DRpre>
    speed      Set JTAG speed. Syntax: speed <freq>|auto|adaptive, e.g. speed 2000, speed a
    i          Read JTAG Id (Host CPU)
    wjc        Write JTAG command (IR). Syntax: wjc <Data>(hex)
    wjd        Write JTAG data (DR). Syntax: wjd <Data32>(hex), <NumBits>(dec)
    RTAP       Reset TAP Controller using state machine (111110)
    wjraw      Write Raw JTAG data. Syntax: wjraw <NumBits(dec)>, <tms>, <tdi>
    rt         Reset TAP Controller (nTRST)
    ---- JTAG-Hardware ---
    c00        Create clock with TDI = TMS = 0
    c          Clock
    0          Clear TDI
    1          Set   TDI
    t0         Clear TMS
    t1         Set   TMS
    trst0      Clear TRST
    trst1      Set   TRST
    r0         Clear RESET
    r1         Set   RESET
    ---- Connection ------
    usb        Connect to J-Link via USB.  Syntax: usb <port>, where port is 0..3
    ip         Connect to J-Link ARM Pro or J-Link TCP/IP Server via TCP/IP.
               Syntax: ip <ip_addr>
    ---- Configuration ---
    si         Select target interface. Syntax: si <Interface>,
               where 0=JTAG and 1=SWD.
    power      Switch power supply for target. Syntax: power <State> [perm],
               where State is either On or Off. Example: power on perm
    wconf      Write configuration byte. Syntax: wconf <offset>, <data>
    rconf      Read configuration bytes. Syntax: rconf
    usbaddr    Assign usb address to the connected J-Link: Syntax: usbaddr = <addr>
    ipaddr     Show/Assign IP address and subnetmask of/to the connected J-Link.
    gwaddr     Show/Assign network gateway address of/to the connected J-Link.
    dnsaddr    Show/Assign network DNS server address of/to the connected J-Link.
    conf       Show configuration of the connected J-Link.
    ecp        Enable the  J-Link control panel.
    ----------------------
    NOTE: Specifying a filename in command line
    will start J-Link Commander in script mode.

    J-Link>rconf
    00000000 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    00000010 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    00000020 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    00000030 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    00000040 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    00000050 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    00000060 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    00000070 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    00000080 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    00000090 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    000000A0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    000000B0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    000000C0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    000000D0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    000000E0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    000000F0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
    J-Link>conf
    USB-Address: Default
    Enum. type:  USB-Address is used
    KS-Power:    Off (Default)
    J-Link>st
    VTarget=0.000V
    ITarget=0mA
    TCK=1 TDI=0 TDO=1 TMS=0 TRES=1 TRST=0
    Supported JTAG speeds:
     - 48 MHz/n, (n>=4). => 12000kHz, 9600kHz, 8000kHz, ...
     - Adaptive clocking
    J-Link>hwinfo
    HWInfo[00] = Target power is disabled
    HWInfo[02] = 0mA	(ITarget)
    HWInfo[03] = 0mA	(ITargetPeak)
    HWInfo[04] = 0mA	(ITargetPeakOperation)
    HWInfo[10] = 0ms	(ITargetMaxTime0)
    HWInfo[11] = 0ms	(ITargetMaxTime1)
    HWInfo[12] = 0ms	(ITargetMaxTime2)
    J-Link>f
    Firmware: J-Link ARM V8 compiled Dec  1 2009 11:42:48
    Hardware: V8.00


From dmesg:

    [  175.220048] usb 4-2: USB disconnect, address 2
    [  175.460040] usb 4-2: new full speed USB device using uhci_hcd and address 3
    [  175.633038] usb 4-2: configuration #1 chosen from 1 choice
    [  180.171835] __ratelimit: 282 callbacks suppressed
    [  180.171839] JLinkExe[2160]: segfault at c ip b75a5c64 sp bfd063f0 error 4 in libjlinkarm.so.0[b751d000+b6000]
    [  269.480074] usb 4-2: USB disconnect, address 3
    [  269.784043] usb 4-2: new full speed USB device using uhci_hcd and address 4
    [  269.967425] usb 4-2: configuration #1 chosen from 1 choice
    [  271.208848] JLinkExe[2186]: segfault at c ip b746acce sp bfa6bc50 error 4 in libjlinkarm.so.0[b73e2000+b6000]



[1]: http://www.at91.com/linux4sam/bin/view/Linux4SAM/SoftwareTools#SAM_BA_Linux_initiative
