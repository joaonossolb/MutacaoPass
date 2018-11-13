#! /bin/bash
vazio(){
echo ""
}

cabecalho(){
vazio
echo "							Mutação PASS"
vazio
echo "Este Script Busca palavras em um determinado site e salva essas palavras em um txt, também é possivel fazer uma mutação com essas palavras"
vazio
echo "O objetivo é auxiliar profissionais na area de segurança da informação desenvolverem melhor suas wordlists personalizadas"
vazio
echo "Não me responsabilizo pelo uso indevido deste script"
vazio
echo "Autor: João Nossol"
vazio
echo "github: https://github.com/joaonossolb"
vazio
echo "como usar:"
echo "			$0 site    - Pega as palavras do site"
echo "			$0 mutacao - Realiza a mutacao de senha"
vazio
echo "Pré Requisitos:"
echo "			Precisa das ferramentas: Cewl e John instalados"
vazio
}



if [ "$1" == "" ];then
	cabecalho
fi

if [ "$1" == "site" ];then
	echo "Digite o site:"
	echo "EX: https://siteexemplo.com"
	echo "EX: www.siteexemplo.com"
        vazio  
        read site
        echo "Digite o numero minimo das letras das palavras que vão ser coletadas (minimo 3) Deixe em branco se não tiver numero de letras das palavras para pegar"
        vazio
        read nletras
	
	echo "Atenção, em sites grandes pode demorar um pouco, se quiser para pressione ctrl+c que irá ser mostrado o que foi coletado em lista.txt"
	if [ "$nletras" == "" ];then
		cewl $site -u googleBot -w lista.txt
	fi

	if [ "$nletras" != "" ];then
		cewl $site -u googleBot -m$nletras -w lista.txt
	fi

fi

if [ "$1" == "mutacao" ];then
	echo "Se quiser uma mutação personalizada, modifique o arquivo /etc/john/john.conf"
	echo "Faça uma busca no arquivo por wordlist show modules"
	echo "No final dessa configuração adicione a sua configuração"
	echo "Exemplo de como configurar"
	vazio
	echo "^ -> Inicio"
	echo "$ -> Final"
	vazio
	echo "EX: $[0-9] -> Numeros de 0 a 9 no fim da senha"
	echo "EX: $[a-z] -> letras de a A z minusculo no fim da senha"
	echo "EX: $[A-Z] -> letras de A a Z maiuscula no fim da senha"
	echo "Da mesma forma funciona para colocar caracteres especiais entre os colchetes"
	echo "Cada um acima quer dizer que irá gerar um caracter, pode ser colocado mais de uma configuração igual para ter 2 3 ou mais caracteres gerados no fim da senha"
	echo "EX: $[0-9]$[0-9]"
	vazio
	echo "Da mesma forma é para gerar os carateres no inicio da senha"
	echo "^[0-9]"
	echo "E assim por diante"
	echo "[...]"
	vazio
	echo "Sem configurar manualmente, ele já faz uma mutação interessante, como escrever as senhas de trás para frente etc..."
	echo "Digite o caminho da lista para fazer a mutação"
        echo "Ex: /root/wordlist.txt"
	vazio
        read caminhomutacao
	if [ "$1" == "" ];then
		echo "Não pode ser vazio"
		exit

	else
		john --wordlist=$caminhomutacao --rules --stdout > listaMutacao.txt
	fi


fi


