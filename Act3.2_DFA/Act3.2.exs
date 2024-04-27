# Implementación básica de autómatas finitos determinísticos
#
# M = (Q, \Sigma, \delta, q_0, F)
#
# Francisco Urquizo Schnaas
# 16/04/24

# Programa de léxer aritmético (autómata finito determinístico)
defmodule TokenList do


  # La función TokenList.arithmetic_lexer, recibe como argumento un string que contiene expresiones aritméticas,
  # y regresa una lista con cada uno de sus tokens encontrados, en el orden en que fueron encontrados e indicando de qué tipo son.
  def arithmetic_lexer(string) do
    # El argumento autómata es expresado de la siguiente manera:
    # {delta, accept, q0}
    automata = {&TokenList.delta_arithmetic/2, [:int, :float, :var, :exp, :int_space, :float_space, :par_close, :var_space, :par_close_space, :dot], :start}
    string
    |> String.graphemes() # Split the string into characters
    |> eval_dfa(automata, [], [])
  end

  # Esta iteración de la función eval_dfa se encarga de desplegar el resultado ya que el arreglo de los caracteres del string original
  # está vacío
  def eval_dfa([], {_delta, accept, state}, tokens, info) do
    cond do
      Enum.member?(accept, state) == true ->cond do
        state == :int_space -> [{:int, Enum.reverse(info) |> Enum.join("")} | tokens] |> Enum.reverse()
        state == :float_space -> [{:float, Enum.reverse(info) |> Enum.join("")} | tokens] |> Enum.reverse()
        state == :var_space -> [{:var, Enum.reverse(info) |> Enum.join("")} | tokens] |> Enum.reverse()
        state == :par_close_space -> [{:par_close, Enum.reverse(info) |> Enum.join("")} | tokens] |> Enum.reverse()
        state == :dot -> [{:float, Enum.reverse(info) |> Enum.join("")} | tokens] |> Enum.reverse()
        true -> [{state, Enum.reverse(info) |> Enum.join("")} | tokens] |> Enum.reverse()
      end
      true -> false
    end
  end

  # Esta iteración de la función eval_dfa se encarga de ir recorriendo los estados del autómata con los caracteres de la lista creada del
  # string original y va recopilando información de los tokens junto con los caracteres que los conforman
  def eval_dfa([char | tail], {delta, accept, state}, tokens, info) do
    #binding() |> IO.inspect()
    [new_state, found] = delta.(state, char) # de la funcion delta, se le pasa el estado actual y el caracter actual, delta es el parametro y el "nuevo nombre" con el cual podemos acceder
    update_info = if char != " " do
      [char | info]
    else
      info
    end

    cond do
      found == false -> eval_dfa(tail, {delta, accept, new_state}, tokens, update_info)
      true -> eval_dfa(tail, {delta, accept, new_state}, [{found, Enum.reverse(tl(update_info)) |> Enum.join("")} | tokens], [hd(update_info)])
    end
    #dentro de la funcion eval_dfa
    # eval_dfa(tail, {delta, accept, new_state}, res)
  end


  # Función de transición que toma un estado y un caracter y regresa un nuevo estado e información acerca de si se añade otro token a la lista
  # de resultados (junto con la identidad de dicho token) o no
  def delta_arithmetic(start, char) do
    case start do
      :start -> cond do
        char == " " -> [:start, false]
        is_sign(char) -> [:sign, false]
        is_digit(char) -> [:int, false]
        is_alpha(char) -> [:var, false]
        char == "(" -> [:par_open, false]
        true -> [:fail, false]
      end

      :int -> cond do
        is_digit(char) -> [:int, false]
        char == " " -> [:int_space, false]
        char == "e" || char == "E" -> [:e, false]
        is_operator(char) -> [:oper, :int]
        char == "." -> [:dot, false]
        char == ")" -> [:par_close, :int]
        true -> [:fail, false]
      end

      :e -> cond do
        is_sign(char) -> [:sign_exp, false]
        is_digit(char) -> [:exp, false]
        true -> [:fail, false]
      end

      :sign_exp -> cond do
        is_digit(char) -> [:exp, false]
        true -> [:fail, false]
      end

      :exp -> cond do
        is_digit(char) -> [:exp, false]
        is_operator(char) -> [:oper, :exp]
        true -> [:fail, false]
      end

      :dot -> cond do
        is_digit(char) -> [:float, false]
        char == " " -> [:float_space, false]
        char == "e" || char == "E" -> [:e, false]
        is_operator(char) -> [:oper, :float]
        char == ")" -> [:par_close, :float]
        true -> [:fail, false]
      end

      :float -> cond do
        is_digit(char) -> [:float, false]
        char == " " -> [:float_space, false]
        char == "e" || char == "E" -> [:e, false]
        is_operator(char) -> [:oper, :float]
        char == ")" -> [:par_close, :float]
        true -> [:fail, false]
      end

      :oper -> cond do
        is_sign(char) -> [:sign, :oper]
        is_alpha(char) -> [:var, :oper]
        char == " " -> [:operator_space, false]
        char == "(" -> [:par_open, :oper]
        is_digit(char) -> [:int, :oper]
        true -> [:fail, false]
      end

      :var -> cond do
       is_alpha(char) -> [:var, false]
       char == " " -> [:var_space, false]
       is_operator(char) -> [:oper, :var]
       is_digit(char) -> [:var, false]
       is_sign(char) -> [:sign, :var]
       char == ")" -> [:par_close, :var]
       true -> [:fail, false]
      end

      :par_open -> cond do
        char == "(" -> [:par_open, :par_open]
        char == " " -> [:par_open_space, false]
        is_alpha(char) -> [:var, :par_open]
        is_digit(char) -> [:int, :par_open]
        is_sign(char) -> [:sign, :par_open]
        true -> [:fail, false]
      end

      :par_close -> cond do
        char == ")" -> [:par_close, :par_close]
        char == " " -> [:par_close_space, false]
        is_operator(char) -> [:oper, :par_close]
        is_sign(char) -> [:sign, :par_close]
        true -> [:fail, false]
      end

      :int_space -> cond do
        char == " " -> [:int_space, false]
        is_operator(char) -> [:oper, :int]
        is_sign(char) -> [:sign, :int]
        true -> [:fail, false]
      end

      :var_space -> cond do
        char == " " -> [:var_space, false]
        is_operator(char) -> [:oper, :var]
        is_sign(char) -> [:sign, :var]
        char == ")" -> [:par_close, :var]
        true -> [:fail, false]
      end

      :float_space -> cond do
        char == " " -> [:float_space, false]
        is_operator(char) -> [:oper, :float]
        is_sign(char) -> [:sign, :float]
        true -> [:fail, false]
      end

      :operator_space -> cond do
        char == " " -> [:operator_space, false]
        is_sign(char) -> [:sign, :oper]
        is_digit(char) -> [:int, :oper]
        is_alpha(char) -> [:var, :oper]
        char == "(" -> [:par_open, :oper]
        true -> [:fail, false]
      end

      :sign_space -> cond do
        char == " " -> [:sign_space, false]
        is_digit(char) -> [:int, false]
        true -> [:fail, false]
      end

      :par_open_space -> cond do
        char == " " -> [:par_open_space, false]
        is_sign(char) -> [:sign, :par_open]
        is_digit(char) -> [:int, :par_open]
        is_alpha(char) -> [:var, :par_open]
        true -> [:fail, false]
      end

      :par_close_space -> cond do
        char == " " -> [:par_close_space, false]
        is_operator(char) -> [:oper, :par_close]
        is_sign(char) -> [:sign, :par_close]
        true -> [:fail, false]
      end

      :sign -> cond do
        is_digit(char) -> [:int, false]
        char == " " -> [:sign_space, false]
        true -> [:fail, false]
      end

      :fail -> [:fail, false]
    end
  end

  # Función auxiliar para checar si un caracter es un dígito
  def is_digit(char) do
    "0123456789"
    |> String.graphemes()
    |> Enum.member?(char)
  end

  # Función auxiliar para checar si un caracter es un signo de más o menos ("+" | "-")
  def is_sign(char) do
    Enum.member?(["+", "-"], char)
  end

  # Función auxiliar para checar si un caracter es un operador
  def is_operator(char) do
    Enum.member?(["+", "-", "*", "/", "%", "=", "^"], char)
  end

  # Función auxiliar para checar si un caracter alfanumérico
  def is_alpha(char) do
    lowercase = ?a..?z |> Enum.map(&<<&1::utf8>>)
    uppercase = ?A..?Z |> Enum.map(&<<&1::utf8>>)
    Enum.member?(lowercase ++ uppercase ++ ["_"], char)
  end


end


# Llamada a la función arithmetic_lexer
IO.inspect(TokenList.arithmetic_lexer("res   = (  38.24 - one ) * 5 - (2.3e-5/toy)"))
