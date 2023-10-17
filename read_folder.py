import os

def ausgabe_verzeichnisstruktur(startpfad="."):
    for root, _, _ in os.walk(startpfad):
        # print("assert os.path.isdir(" & root & ")")
        print(f"assert os.path.isdir('{root}')")

if __name__ == "__main__":
    pfad = input("Geben Sie den Pfad des Verzeichnisses ein (oder drücken Sie Enter für das aktuelle Verzeichnis): ")
    if not pfad:
        pfad = "."
    ausgabe_verzeichnisstruktur(pfad)
