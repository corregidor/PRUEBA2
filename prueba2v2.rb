
def menu()
	puts '--+--+--+--+--+--+-- M E N U --+--+----+--+--+--+'
	puts '--+--+--+--+--+--+--+--+--+--+--+--+----+--+--+--'
	puts '1) Crear un archivo por alumno.'
	puts '2) Cuantas Ausencias.'
	puts '3) Verificar si aprueba.'
	puts '4) Salir.'
	puts '--+--+--+--+--+--+--+--+--+--+--+--+----+--+--+--'
end

# -------------------------------------------------------------------------------------------------
# +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
# -------------------------------------------------------------------------------------------------

def option_of_menu()
	puts '--+--+--+--+--+--+--+--+--+--+--+--+----+--+--+--'
	puts 'Ingrese una opción del menu: '
	opt = gets.chomp
end

def leer_archivo(nombrearchivo)
	file = File.open(nombrearchivo, 'r')
		data = file.readlines
	file.close

 	aux = []
	data.each do |line|
		aux << line.split(', ')
	end

	return aux
	#puede ir sin return
end
# leer_archivo("data.csv")

def archiv_x_alumno(data)
	for nombre, not1, not2, not3, not4, not5 in data
		File.open(nombre.to_s+'.txt', 'w') do |archivo|
			archivo.puts "Nombre: #{nombre}"
			archivo.puts "Nota 1: #{not1}"
			archivo.puts "Nota 2: #{not2}"
			archivo.puts "Nota 3: #{not3}"
			archivo.puts "Nota 4: #{not4}"
			archivo.puts "Nota 5: #{not5}"
		end
	end
	puts 'Archivos Creados !!'
end

# archiv_x_alumno(leer_archivo("data.csv"))

def alumno_ausente(data)
	for v in data
		print "Nombre: #{v[0]}, Ausencias: " + v.select {|i| i == 'A'}.size().to_s + "\n"
	end
end

# alumno_ausente(leer_archivo('data.csv'))


def notaminima(nota)
	if nota.to_i
		return 1
	else
		return nota
	end
end

def opt_nota_para_aprobar()
	puts '--+--+--+--+--+--+--+--+--+--+--+--+----+--+--+--'
	puts 'Ingrese la nota minima para aprobar: '
	opt = gets.chomp.to_i
end

def promedio_total(data, nota_para_aprobar)
	#la nota debe ser por defecto 5.0, no es mala idea parametrizar
	nota = 0
	data.each do |nombre, not1, not2, not3, not4, not5|
		puts "Nombre: #{nombre}"
		nota = (not1.to_f + not2.to_f + not3.to_f + not4.to_f + not5.to_f)
		prom = nota / 5
		#debiera de contar el array y no suponerlo escrito como 5
		puts "Promedio: #{prom} "

		if prom >= nota_para_aprobar and nota_para_aprobar != ''
			#and no es una buena opcion, es mejor utilizar &&
			puts 'APROBADO PERRITO!'
		else
			puts 'ESTAMOS EN LA B!!!!'
		end
	end

end

# -------------------------------------------------------------------------------------------------
# +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
# -------------------------------------------------------------------------------------------------

def pantalla(data_eval)
	opt = ''
	while opt == ''
	menu()
	opt = option_of_menu().to_i
		case opt
		when 1
			begin
				archiv_x_alumno(data_eval)
				rescue Exception => msg  
				puts 'algo salio mal:'
				puts msg
				#excelente incluir un rescue!
			end
			opt = ''
		when 2
			alumno_ausente(data_eval)
			opt = ''
		when 3
			promedio_total(data_eval, opt_nota_para_aprobar())
			opt = ''
		when 4
			exit()
		else
			puts 'La Opción Ingresada no es VALIDA!'
		end
	end
end

pantalla(leer_archivo('data.csv'))