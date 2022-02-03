#include <iostream>
#include <string>
#include <Windows.h>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

bool SelectComPort() //added function to find the present serial 
{
    char lpTargetPath[5000]; // buffer to store the path of the COMPORTS
    bool gotPort = false; // in case the port is not found
    char ports[255];

    for (int i = 0; i < 255; i++) // checking ports from COM0 to COM255
    {
        std::string str = "COM" + std::to_string(i); // converting to COM0, COM1, COM2
        DWORD test = QueryDosDevice(str.c_str(), lpTargetPath, 5000);

        // Test the return value and error if any
        if (test != 0) //QueryDosDevice returns zero if it didn't find an object
        {
            //std::cout << str << std::endl;
            
            gotPort = true;
            if(ports[i] != true){
            	ports[i] = true;
            	 std::string str2 = "Connect new Device " + str;
				MessageBoxA(NULL, str2.c_str() , str.c_str() ,MB_OK);
			}
        }else{
        	ports[i] = false;
		}
		

        if (::GetLastError() == ERROR_INSUFFICIENT_BUFFER)
        {
        }
    }

    return gotPort;
}



int main(int argc, char** argv) {
	HWND hWnd = GetForegroundWindow();
    ShowWindow(hWnd,SW_HIDE);
	while (2 + 2 == 4){
		SelectComPort();
		sleep(1);
	}
	return 0;
}

