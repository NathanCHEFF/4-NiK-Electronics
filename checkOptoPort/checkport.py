import serial
import time
import sys

#ports = ["/dev/ttyS1", "/dev/ttyS2", "/dev/ttyS3", "/dev/ttyS4", "/dev/ttyS5"]

# запуск  python3 /media/LIB/checkport.py testTwoPorts 2 3
# проверит 2 и 3 порты
# запуск  python3 /media/LIB/checkport.py testЩтуPort 2 
# проверит 2  порт

pack1 = '101010101010'.encode('utf-8')
pack2 = '5e2da7c6'.encode('utf-8')
pack3 = b'\xd0\x91\xd0\xb0\xd0\xb9\xd1\x82\xd1\x8b'
pack4 = "Жуйня".encode('utf-8')
pack5 = "уважаемый! в этом пакете ну уж очень много всякой Жуйни".encode('utf-8')

def out_end():
    print("\033[0m{}".format(''))
def out_red(text):
    print("\033[31m{}" .format(text))
    out_end()
def out_yellow(text):
    print("\033[33m{}" .format(text))
    out_end()
def out_blue(text):
    print("\033[34m{}" .format(text))
    out_end()
def out_green(text):
    print("\033[32m{}" .format(text))
    out_end()
    
def testOnePort( intport ):
    out = b''

    ser = serial.Serial(
        port='/dev/ttyS' + str(intport),
        baudrate=9600,
        timeout = 3.5
    )
    ser.isOpen()
    ser.write(pack5)
    time.sleep(1)
    while ser.inWaiting() > 0:
        out += ser.read(1)
    #print(out)
    #print(out.decode())
    
    if out == pack5 :

        out_green("Принятый пакет совпал с посланым!")
    else:
        out_red("Принятый пакет НЕ совпал с посланым!")
        out_red("передали :")
        out_yellow(pack5)
        out_red("Получили :")
        out_yellow(out)
    ser.close()
    
#testOnePort(3)

def testTwoPorts(oneport, twoport):
    out = b''
    
    rx_one=False
    tx_one=False
    rx_two=False
    tx_two=False
    
    ser1 = serial.Serial(
        port='/dev/ttyS' + str(oneport),  
        baudrate=9600,
        timeout = 3.5
    )
    
    ser2 = serial.Serial(
        port='/dev/ttyS' + str(twoport),
        baudrate=9600,
        timeout = 3.5
    )

    ser1.isOpen()
    ser2.isOpen()
    
    out_blue("send from port " + str(oneport) + " to port" + str(twoport) + '\r')
    out_blue("RX:" + str(twoport)+ " TX:"+ str(oneport)+ '\r' )
    ser1.write(pack5)
    time.sleep(1)
    while ser2.inWaiting() > 0:
        out += ser2.read(1)
        
    #out_yellow(out)
    #out_yellow(out.decode())
    
    if out == pack5 :
        tx_two=True
        rx_one=True
        out_green("Принятый пакет совпал с посланым!")
    else:
        out_red("Принятый пакет НЕ совпал с посланым!")
        out_red("передали :")
        out_yellow(pack5)
        out_red("Получили :")
        out_yellow(out)
        
        
    
    out_blue("send from port " + str(twoport) + " to port" + str(oneport) + '\r')
    out_blue("RX:" + str(oneport) + " TX:"+ str(twoport)+ '\r' )
    ser2.write(pack5)
    time.sleep(1)
    while ser2.inWaiting() > 0:
        out += ser2.read(1)
        
    #out_yellow(out)
    #out_yellow(out.decode())
    
    if out == pack5 :
        tx_one=True
        rx_two=True
        out_green("Принятый пакет совпал с посланым!")
    else:
        out_red("Принятый пакет НЕ совпал с посланым!")
        out_red("передали :")
        out_yellow(pack5)
        out_red("Получили :")
        out_yellow(out)
        
    
    print( "tx порта " + str(oneport)+ " - " + str(tx_one) )
    print( "rx порта " + str(oneport)+ " - " + str(rx_one) )
    print( "tx порта " + str(twoport)+ " - " + str(tx_two) )
    print( "rx порта " + str(twoport)+ " - " + str(rx_two) )
    
    if tx_one and rx_one and tx_two and rx_two :
        out_green ("порты "+ str(oneport) + " и " + str(twoport) +" исправны"+ '\r')
    
    else:
        out_red ( "эжуйня" )
    
    ser1.close()
    ser2.close()  
     

#testTwoPorts(2, 3)


if __name__ == "__main__":
    if len (sys.argv) > 1:
        #print (sys.argv[1] )
        
        if sys.argv[1] == "testOnePort": 
            testOnePort(sys.argv[2])
            
        if sys.argv[1] == "testTwoPorts": 
            testTwoPorts(sys.argv[2], sys.argv[3])
            
