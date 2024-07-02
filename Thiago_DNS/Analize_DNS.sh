#!/bin/bash

#Este script realiza o teste da resolução de um DNS especificado para um host especificado
#

owner_project="Thiago Souza"

banner=$( toilet -f smblock --filter border --filter metal THS - DNS )

#CABEÇALHO DE INFORMAÇÕES
echo -e "========================================================================="

echo -e "$banner"

echo -e "Esse script realiza a consulta ao server DNS para resolução de nomes"
echo -e "Finalidade: Análise de DNS para resolução de nomes"
echo -e "Owner_script: Thiago Souza"
echo -e "Script github:https://github.com/thiago031996/Script_DNS_analise"

echo -e "=========================================================================="
#DADOS INSERIDOS PELO USUÁRIO
echo "Informe o DNS que será usado para a resolução: "
read dns
printf "\n"

echo "Informe o IP / Dominio para consulta: "
read ip_domain
printf "\n"

#(dig)ANÁLISE DNS PARA O DOMÍNEO COM OS FILTROS APLICADOS
echo -e "==============================================================="

echo "INFORMAÇÕES DA RESOLUÇÃO:"

dig +time=1 +tries=2 @$dns $ip_domain | grep NOERROR && echo O DNS:"$dns" Resolveu o Endereço:"$ip_domain" com sucesso! || echo o DNS: "$dns" não conseguiu resolver o Endereço:"$ip_domain"

printf "\n"

dig +time=1 +tries=2 @$dns $ip_domain | tail -n5

echo -e "==============================================================="

printf "\n"

echo "INFORMAÇÕES DNS:$dns"

inf_dns=$(whois -h whois.cymru.com " -v $dns")

printf "\n"

echo "$inf_dns" 

#CONSULTA REVERSA
for ip in "${dns[@]}"; do
  echo "Consultando reverso para IP: $ip"
  nome_reverso=$(dig +short -x "$ip")
  if [ -n "$nome_reverso" ]; then
    echo "Nome de domínio: $nome_reverso"
  else
    echo "Não foi possível resolver o IP: $ip"
  fi
  echo ""

done

#TESTE PING PARA O DNS
ping=$(ping -c 4 -W 1 $dns)
result_ping=$(echo "$ping"| tail -n3)

echo -e "==============================================================="

printf "\n"

echo " Testando ping..."
echo " 4 pacotes enviados para:$dns "


printf "\n"

echo "Dados teste PING:$result_ping"

echo -e "================================================================"

