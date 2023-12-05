from pydub import AudioSegment

#Forzar el audio a una tasa de muestreo de 13000Hz y una profundidad de 16 bits
def convert_wav_to_mono(input_file, output_file, sample_width=2, framerate=13000):
    audio = AudioSegment.from_wav(input_file)
    audio = audio.set_channels(1)
    audio = audio.set_frame_rate(framerate)
    audio = audio.set_sample_width(sample_width)
    audio.export(output_file, format='wav')
    print("Archivo mono guardado:", output_file)


# Declaraicón de entradas y salidas
input_wav = 'Ausente.wav'
output_mono_wav = 'A_mono.wav'


# Convertir a mono
convert_wav_to_mono(input_wav, output_mono_wav)


print('done')
