{ arch ? "x64" }:

let
  pkgs = import <nixpkgs> {};
  mingw = if arch == "x64" then pkgs.pkgsCross.mingwW64.stdenv else pkgs.pkgsCross.mingw32.stdenv;
in mingw.mkDerivation {
  pname = "hello-world";
  version = "0.1.0";
  src = ./.;

  nativeBuildInputs = [ pkgs.nasm ];

  buildPhase = ''
    # set -x  # Enable verbose output
    
    ## Assembly -- Start

    # Use the specified architecture
    ASSEMBLY_FILE="assembly_${arch}.asm"
    NASM_FORMAT="${if arch == "x64" then "win64" else "win32"}"

    echo "NASM version:"
    nasm -v

    echo "Compiling assembly file:"
    nasm -f $NASM_FORMAT "$ASSEMBLY_FILE" -o assembly.obj

    echo "Directory contents after NASM:"
    ls -l

    if [ ! -f assembly.obj ]; then
      echo "NASM compilation failed. Assembly object file not created."
      exit 1
    fi

    echo "Assembly object file created:"
    ls -l assembly.obj

    echo "Symbols in assembly.obj:"
    $OBJDUMP -t assembly.obj

    ## Assembly -- End
    ## C - Start

    echo "Compiling C file:"
    $CC -c main.c -o main.o

    echo "C file compilation result:"
    ls -l main.o

    echo "Symbols in main.o:"
    $OBJDUMP -t main.o

    echo "Linking object files:"
    $CC -o hello_world.exe main.o assembly.obj -luser32

    ## C -- End

    echo "Linking result:"
    ls -l hello_world.exe || echo "Executable not created"

    # set +x  # Disable verbose output
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp hello_world.exe $out/bin/
  '';

  meta = with pkgs.lib; {
    description = "A simple Hello World program compiled for Windows";
    platforms = platforms.windows;
  };
}
