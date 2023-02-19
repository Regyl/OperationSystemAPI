#include <windows.h>
#include <iostream>
#include <string>


void checkInput(int argc, char **argv);

void processException();

int main(int argc, char *argv[]) {
    checkInput(argc, argv);

    LPCSTR path = argv[1];
    LPCSTR filePrefix = argv[2];
    LPSTR tempFileName = nullptr;
    if (GetTempFileNameA(path, filePrefix, 0, tempFileName) != 0) {
        std::string tempFileNameAsString = tempFileName;
        std::cerr << "File name: " << tempFileNameAsString << std::endl;
    } else {
        processException();
    }
    return 0;
}

void checkInput(int argc, char **argv) {
    if (argc != 3) {
            std::cerr << "Wrong parameter quantity: " << argc << std::endl;
            for (int i = 0; i < argc; i++) {
                std::cerr << "Parameter: " << argv[i] << std::endl;
            }
        std::terminate();
    }
}

void processException() {
    DWORD error = GetLastError();
    switch (error) {
        case 5:
            std::cerr << "Wrong temp file path " << std::endl;
        default:
            std::cerr << "Unhandled error: " << error << std::endl;
    }
}

