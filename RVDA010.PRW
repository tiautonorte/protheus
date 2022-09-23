#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ RVDA010  ³ Autor ³ Italo Maciel    ³ Data ³ 26/03/19       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio Resumo Diário								      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
user Function RVDA010()
	Local oReport
	Local cAlias1 := getNextAlias()
	Local cAlias2 := getNextAlias()
	Local cAlias3 := getNextAlias()

	Private cPerg := "RVDA010"

	//CriaSx1(cPerg)

	oReport := ReportDef(cAlias1,cAlias2,cAlias3,cPerg)
	oReport:PrintDialog()

Return


Static Function ReportDef(cAlias1,cAlias2,cAlias3,cPerg)
	Local oReport  
	Local oSection1
	Local oSection2
	Local oSection3
	Local oBreak1
	Local oBreak2
	Local oBreak3

	oReport := TReport():New("RVDA010","Relatório de Resumo Diário",cPerg,{|oReport| ReportPrint(oReport,cAlias1,cAlias2,cAlias3)},"")
	oReport:nFontBody := 10
	oReport:SetLineHeight(60)

	Pergunte(cPerg, .T.)

	oSection1 := TRSection():New(oReport,"SAIDAS",,,,,,,,,,,,.T.,)
	oSection1:SetPercentage(70)

	TRCell():New(oSection1,"D2_TOTAL"		,,"VLR PRODUTOS VENDA............","@E 999,999,999.99",14,.F.,)
	TRCell():New(oSection1,"D2_VALFRE"		,,"VLR FRETE.....................","@E 999,999,999.99",14,.F.,)
	TRCell():New(oSection1,"D2_DESPESA"		,,"VLR DESP. ACESSORIA...........","@E 999,999,999.99",14,.F.,)
	TRCell():New(oSection1,"T_FRE_DESP"		,,"VLR PROD + FRETE + DESP. ACES.","@E 999,999,999.99",14,.F.,)
	TRCell():New(oSection1,"D2_ICMSRET"		,,"VLR ICMS-ST...................","@E 999,999,999.99",14,.F.,)
	TRCell():New(oSection1,"TOT_FRE_DES_ICM",,"VLR TOTAL VDA INTERNA.........","@E 999,999,999.99",14,.F.,)
	TRCell():New(oSection1,"D2_QUANT"		,,""						      ,"@E 999,999.99"	  ,10,.F.,)
	TRCell():New(oSection1,"PRE_PROCES"		,,"PEDIDO EM SEPARAÇÃO...........","@E 999,999,999.99",14,.F.,)
	TRCell():New(oSection1,"PRE_ABERTO"		,,"PEDIDO EM ABERTO..............","@E 999,999,999.99",14,.F.,)
	TRCell():New(oSection1,"VEND_CANC"		,,"VENDAS CANCELADAS.............","@E 999,999,999.99",14,.F.,)
	TRCell():New(oSection1,"VEND_CANC_QUANT",,""						      ,"@E 999,999.99"	  ,10,.F.,)
	TRCell():New(oSection1,"TRANSF"			,,"TRANSFERENCIAS................","@E 999,999,999.99",14,.F.,)
	TRCell():New(oSection1,"TRANSF_QUANT"	,,""						      ,"@E 999,999.99"	  ,10,.F.,)

	oSection2 := TRSection():New(oReport,"ENTRADAS",,,,,,,,,,,,,)

	TRCell():New(oSection2,"X5_DESCRI"	,,"TIPO DE MOVIMENTACAO",""		,30,.F.,)
	TRCell():New(oSection2,"TOTAL"		,,"VALOR"	,"@E 999,999,999.99",14,.F.,)
	TRCell():New(oSection2,"QUANT"		,,"QUANT."	,"@E 999,999,999.99",14,.F.,)

	oSection3 := TRSection():New(oReport,"PEDIDOS_SEP",,,,,,,,,,,,,)

	TRCell():New(oSection3,"C6_FILIAL"	,,"FILIAL"	,"",TamSx3("C6_FILIAL")[1],.F.,)
	TRCell():New(oSection3,"C6_NUM"		,,"PEDIDO"	,"",TamSx3("C6_NUM")[1],.F.,)
	TRCell():New(oSection3,"A1_COD"		,,"CLIENTE"	,"",30,.F.,{|| (cAlias3)->A1_COD + ' - ' + (cAlias3)->A1_NOME })
	TRCell():New(oSection3,"C5_EMISSAO"	,,"DATA"	,"",10,.F.,)
	TRCell():New(oSection3,"VALOR"		,,"VALOR"	,"@E 999,999,999.99",14,.F.,)

Return oReport


Static Function ReportPrint(oReport,cAlias1,cAlias2,cAlias3)

	Local oSection1 := oReport:Section(1)
	Local oSection2 := oReport:Section(2)
	Local oSection3 := oReport:Section(3)
	Local cOrdem
	Local cFilPar
	Local oFont
	Local cFilSC6
	Local cFilSFT
	Local cFilSD2
	Local cFilSD1

	MakeSqlExpr("RVDA010")

	If ! Empty(MV_PAR01)
		cFilPar := "%"+MV_PAR01+" AND %"
	Else
		cFilPar := "% %"
	EndIf

	If "IN" $ cFilPar 
		cFilSC6 := StrTran(cFilPar,"IN","C6_FILIAL IN")
		cFilSFT := StrTran(cFilPar,"IN","FT_FILIAL IN")
		cFilSD2 := StrTran(cFilPar,"IN","D2_FILIAL IN")
		cFilSD1 := StrTran(cFilPar,"IN","D1_FILIAL IN")
	ElseIf "BETWEEN" $ cFilPar
		cFilSC6 := StrTran(cFilPar,"BETWEEN","C6_FILIAL BETWEEN")
		cFilSFT := StrTran(cFilPar,"BETWEEN","FT_FILIAL BETWEEN")
		cFilSD2 := StrTran(cFilPar,"BETWEEN","D2_FILIAL BETWEEN")
		cFilSD1 := StrTran(cFilPar,"BETWEEN","D1_FILIAL BETWEEN")
	EndIf

	oSection1:BeginQuery()

	BeginSQL Alias cAlias1
		//AND F1_FILIAL BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%

		SELECT 
		SUM(A.D2_TOTAL) D2_TOTAL,
		SUM(A.D2_VALFRE) D2_VALFRE,
		SUM(A.D2_DESPESA) D2_DESPESA,
		SUM(A.D2_TOTAL + A.D2_VALFRE + A.D2_DESPESA) T_FRE_DESP,
		SUM(A.D2_ICMSRET) D2_ICMSRET,
		SUM(A.D2_TOTAL + A.D2_VALFRE + A.D2_DESPESA + A.D2_ICMSRET) TOT_FRE_DES_ICM,
		AVG((SELECT COUNT(*) FROM %Table:SD2% A WHERE A.%notDel%
		AND %Exp:cFilSD2% A.D2_EMISSAO BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%
		AND D2_XOPER = '01' AND D2_ITEM = '01' )) D2_QUANT,
		AVG(
		(SELECT SUM(C6_VALOR) FROM %Table:SC6% A
		INNER JOIN %Table:SC5% B ON C5_FILIAL = C6_FILIAL AND C5_NUM = C6_NUM AND B.%notDel%
		INNER JOIN %Table:D01% C ON C5_FILIAL = D01_XFILOR AND C5_NUM = D01_XPEDID AND C.%notDel%
		WHERE A.%notDel% 
		AND C6_XOPER = '01'
		AND C6_NOTA = ' '
		AND D01_XSTAT NOT IN (' ','0','5','6','7') //Alterado 12/09 - Álvaro - Foi tirado o 1
		//AND D01_STATUS IN ('2','3') alterado para o xstat dia 02/09/22
		AND %Exp:cFilSC6% 
		C5_EMISSAO BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%)
		) PRE_PROCES,
		AVG(
		(SELECT SUM(C6_VALOR) FROM %Table:SC6% A
		INNER JOIN %Table:SC5% B ON C5_FILIAL = C6_FILIAL AND C5_NUM = C6_NUM AND B.%notDel%
		INNER JOIN %Table:D01% C ON C5_FILIAL = D01_XFILOR AND C5_NUM = D01_XPEDID AND C.%notDel%
		WHERE A.%notDel% 
		AND C6_XOPER = '01'
		AND D01_XSTAT IN (' ', '0') //Alterado 12/09 - Álvaro - Foi comentado o campo Status e criado o IN
		//AND D01_STATUS = '1'
		AND %Exp:cFilSC6% 
		C5_EMISSAO BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%)
		) PRE_ABERTO,
		AVG(
		(SELECT SUM(D2_TOTAL) FROM %Table:SFT% A
		INNER JOIN %Table:SD2% B ON D2_FILIAL = FT_FILIAL AND D2_DOC = FT_NFISCAL AND D2_SERIE = FT_SERIE AND D2_ITEM = FT_ITEM AND D2_COD = FT_PRODUTO AND B.D_E_L_E_T_ = '*'
		WHERE A.%notDel%
		AND D2_XOPER = '01'
		AND %Exp:cFilSFT% 
		FT_DTCANC BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%
		AND FT_TIPOMOV = 'S')
		) VEND_CANC,
		AVG(
		(SELECT COUNT(*) FROM %Table:SFT% A
		INNER JOIN %Table:SD2% B ON D2_FILIAL = FT_FILIAL AND D2_DOC = FT_NFISCAL AND D2_SERIE = FT_SERIE AND D2_ITEM = '01' AND B.D_E_L_E_T_ = '*'
		WHERE A.%notDel%
		AND D2_XOPER = '01'
		AND %Exp:cFilSFT% 
		FT_DTCANC BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%
		AND FT_ITEM = '01'
		AND FT_TIPOMOV = 'S')
		) VEND_CANC_QUANT,
		AVG(
		(SELECT SUM(C6_VALOR) FROM %Table:SC6% A
		INNER JOIN %Table:SC5% B ON C5_FILIAL = C6_FILIAL AND C5_NUM = C6_NUM AND B.%notDel%
		INNER JOIN %Table:D01% C ON C5_FILIAL = D01_XFILOR AND C5_NUM = D01_XPEDID AND C.%notDel%
		WHERE A.%notDel% 
		AND %Exp:cFilSC6% 
		C5_EMISSAO BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%
		AND C6_XOPER IN (SELECT X5_CHAVE FROM SX5010 WHERE X5_TABELA = 'DJ' AND X5_DESCRI LIKE '%TRANS%' AND %notDel%))
		) TRANSF,
		AVG(
		(SELECT SUM(C6_QTDVEN) FROM %Table:SC6% A
		INNER JOIN %Table:SC5% B ON C5_FILIAL = C6_FILIAL AND C5_NUM = C6_NUM AND B.%notDel%
		INNER JOIN %Table:D01% C ON C5_FILIAL = D01_XFILOR AND C5_NUM = D01_XPEDID AND C.%notDel%
		WHERE A.%notDel% 
		AND %Exp:cFilSC6% C5_EMISSAO BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%
		AND C6_XOPER IN (SELECT X5_CHAVE FROM %Table:SX5% WHERE X5_TABELA = 'DJ' AND X5_DESCRI LIKE '%TRANS%' AND %notDel%))
		) TRANSF_QUANT
		FROM %Table:SD2% A
		INNER JOIN %Table:SC6% B ON D2_FILIAL = C6_FILIAL AND D2_PEDIDO = C6_NUM AND D2_ITEMPV = C6_ITEM AND B.%notDel%
		WHERE A.%notDel%
		AND C6_XOPER = '01'
		AND %Exp:cFilSD2% 
		A.D2_EMISSAO BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%

	EndSQL

	oSection1:EndQuery()

	oReport:SetMeter((cAlias1)->(RecCount()))

	//Objeto fonte do texto fixo
	oFont := TFont():New('Courier new',,12,.T.,.F.)
	/*
	Say(nRow,nCol,cText,oFont,nWidth,nClrText,nBkMode,nPad)
	Imprime um texto no relatório.

	nRow		Linha para impressão do texto
	nCol		Coluna para impressão do texto
	cText		Texto que sera impresso
	oFont		Objeto da classe TFont
	nWidth		Tamanho em pixel do texto para impressão
	nClrText	Cor da fonte
	nBkMode	Compatibilidade – Não utilizado
	nPad		Compatibilidade – Não utilizado
	*/
	oReport:Say(oReport:Row(),100,"",oFont)//Compatibilizar
	oReport:Say(oReport:Row(),650,"SAÍDAS",oFont)
	//Pula linha
	oReport:SkipLine()
	//Imprime linha de separação
	oReport:Line(oReport:Row(),10,oReport:Row(),1475)
	//Pula linha
	oReport:SkipLine()
	//Imprime texto fixo
	oReport:Say(oReport:Row(),10	,"TIPO DE MOVIMENTACAO"	,oFont)
	oReport:Say(oReport:Row(),800	,"VALOR"				,oFont)
	oReport:Say(oReport:Row(),1100	,"QUANT."				,oFont)
	oReport:SkipLine()
	//Imprime linha de separação
	oReport:Line(oReport:Row(),10,oReport:Row(),1475)
	//Pula linha
	oReport:SkipLine()
	//Imprime resultado da query
	oSection1:Print()

	oSection2:BeginQuery()

	BeginSQL Alias cAlias2

		SELECT X5_CHAVE, UPPER(X5_DESCRI) X5_DESCRI, SUM(D1_TOTAL) TOTAL, SUM(D1_QUANT) QUANT 
		FROM %Table:SD1% A
		INNER JOIN %Table:SX5% B ON X5_TABELA = 'DJ' AND X5_CHAVE = D1_XOPER AND B.%notDel%
		WHERE A.%notDel%
		AND %Exp:cFilSD1% 
		D1_DTDIGIT BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%
		GROUP BY X5_CHAVE,UPPER(X5_DESCRI)
		ORDER BY X5_CHAVE

	EndSQL

	oSection2:EndQuery()

	oReport:SetMeter((cAlias2)->(RecCount()))
	//Pula linha
	oReport:SkipLine()
	oReport:SkipLine()
	oReport:Say(oReport:Row(),630,"ENTRADAS",oFont)
	//Pula linha
	oReport:SkipLine()
	//Imprime linha de separação
	oReport:Line(oReport:Row(),10,oReport:Row(),1475)
	//Imprime resultado da query
	oSection2:Print()


	oSection3:BeginQuery()

	BeginSQL Alias cAlias3

		SELECT C6_FILIAL,C6_NUM,A1_COD,A1_NOME,C5_EMISSAO,SUM(C6_VALOR) VALOR
		FROM %Table:SC6% A
		INNER JOIN %Table:SC5% B ON C5_FILIAL = C6_FILIAL AND C5_NUM = C6_NUM AND B.D_E_L_E_T_ = ' '
		INNER JOIN %Table:D01% C ON C5_FILIAL = D01_XFILOR AND C5_NUM = D01_XPEDID AND C.D_E_L_E_T_ = ' '
		INNER JOIN %Table:SA1% D ON A1_COD = C5_CLIENTE AND C5_LOJACLI = A1_LOJA AND D.D_E_L_E_T_ = ' '
		WHERE A.D_E_L_E_T_ = ' ' 
		AND C6_XOPER = '01'
		AND C6_NOTA = ' '
		AND D01_XSTAT NOT IN (' ','0') //teste
		//AND D01_STATUS IN ('2','3') AND D01_XUSLIB = ' '
		AND %Exp:cFilSC6% 
		C5_EMISSAO BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%
		GROUP BY C6_FILIAL,C6_NUM,A1_COD,A1_NOME,C5_EMISSAO

	EndSQL

	oSection3:EndQuery()
	
	oReport:SetMeter((cAlias3)->(RecCount()))

	//Pula linha
	oReport:SkipLine()
	oReport:SkipLine()
	oReport:Say(oReport:Row(),630,"PEDIDOS EM SEPARAÇÃO",oFont)
	//Pula linha
	oReport:SkipLine()
	//Imprime linha de separação
	oReport:Line(oReport:Row(),10,oReport:Row(),1705)
	//Imprime resultado da query
	oSection3:Print()

return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³CriaSX1   ³ Autor ³ Marcelo Celi Marques  ³ Data ³ 02/10/08³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Atualiza perguntas no SX1                              	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³CriaSX1() 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³FINR501()     											  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CriaSx1(cPerg)

	Local aArea 	:= GetArea()
	Local aHelpPor 	:= {}

	xPutSx1(cPerg,"01","Filiais"," "," ","mv_ch1",;
	"C",50,0,0,"R","","SM0","","S","mv_par01"," "," "," ","",;
	" "," "," "," "," "," ", " "," "," "," "," "," ",;
	aHelpPor,,)

	xPutSx1(cPerg,"02","Data De","","","mv_ch2",;
	"D",8,0,0,"G","","","","S","mv_par02"," "," "," "," ",;
	" "," "," "," "," "," ", " "," "," "," "," "," ",;
	aHelpPor,,)

	xPutSx1(cPerg,"03","Data Ate","","","mv_ch3",;
	"D",8,0,0,"G","","","","S","mv_par03"," "," "," "," ",;
	" "," "," "," "," "," ", " "," "," "," "," "," ",;
	aHelpPor,,)

	RestArea(aArea)
Return                                       
/*
//Gravar pergunta na SX1
Static Function xPutSx1(cGrupo,cOrdem,cPergunt,cPerSpa,cPerEng,cVar,;
	cTipo ,nTamanho,nDecimal,nPresel,cGSC,cValid,;
	cF3, cGrpSxg,cPyme,;
	cVar01,cDef01,cDefSpa1,cDefEng1,cCnt01,;
	cDef02,cDefSpa2,cDefEng2,;
	cDef03,cDefSpa3,cDefEng3,;
	cDef04,cDefSpa4,cDefEng4,;
	cDef05,cDefSpa5,cDefEng5,;
	aHelpPor,aHelpEng,aHelpSpa,cHelp)

	LOCAL aArea := GetArea()
	Local cKey
	Local lPort := .f.
	Local lSpa := .f.
	Local lIngl := .f.

	cKey := "P." + AllTrim( cGrupo ) + AllTrim( cOrdem ) + "."

	cPyme    := Iif( cPyme           == Nil, " ", cPyme          )
	cF3      := Iif( cF3           == NIl, " ", cF3          )
	cGrpSxg := Iif( cGrpSxg     == Nil, " ", cGrpSxg     )
	cCnt01   := Iif( cCnt01          == Nil, "" , cCnt01      )
	cHelp      := Iif( cHelp          == Nil, "" , cHelp          )

	dbSelectArea( "SX1" )
	dbSetOrder( 1 )

	// Ajusta o tamanho do grupo. Ajuste emergencial para validação dos fontes.
	// RFC - 15/03/2007
	cGrupo := PadR( cGrupo , Len( SX1->X1_GRUPO ) , " " )

	If !( DbSeek( cGrupo + cOrdem ))

		cPergunt:= If(! "?" $ cPergunt .And. ! Empty(cPergunt),Alltrim(cPergunt)+" ?",cPergunt)
		cPerSpa     := If(! "?" $ cPerSpa .And. ! Empty(cPerSpa) ,Alltrim(cPerSpa) +" ?",cPerSpa)
		cPerEng     := If(! "?" $ cPerEng .And. ! Empty(cPerEng) ,Alltrim(cPerEng) +" ?",cPerEng)

		Reclock( "SX1" , .T. )

		Replace X1_GRUPO   With cGrupo
		Replace X1_ORDEM   With cOrdem
		Replace X1_PERGUNT With cPergunt
		Replace X1_PERSPA With cPerSpa
		Replace X1_PERENG With cPerEng
		Replace X1_VARIAVL With cVar
		Replace X1_TIPO    With cTipo
		Replace X1_TAMANHO With nTamanho
		Replace X1_DECIMAL With nDecimal
		Replace X1_PRESEL With nPresel
		Replace X1_GSC     With cGSC
		Replace X1_VALID   With cValid

		Replace X1_VAR01   With cVar01

		Replace X1_F3      With cF3
		Replace X1_GRPSXG With cGrpSxg

		If Fieldpos("X1_PYME") > 0
			If cPyme != Nil
				Replace X1_PYME With cPyme
			Endif
		Endif

		Replace X1_CNT01   With cCnt01
		If cGSC == "C"               // Mult Escolha
			Replace X1_DEF01   With cDef01
			Replace X1_DEFSPA1 With cDefSpa1
			Replace X1_DEFENG1 With cDefEng1

			Replace X1_DEF02   With cDef02
			Replace X1_DEFSPA2 With cDefSpa2
			Replace X1_DEFENG2 With cDefEng2

			Replace X1_DEF03   With cDef03
			Replace X1_DEFSPA3 With cDefSpa3
			Replace X1_DEFENG3 With cDefEng3

			Replace X1_DEF04   With cDef04
			Replace X1_DEFSPA4 With cDefSpa4
			Replace X1_DEFENG4 With cDefEng4

			Replace X1_DEF05   With cDef05
			Replace X1_DEFSPA5 With cDefSpa5
			Replace X1_DEFENG5 With cDefEng5
		Endif

		Replace X1_HELP With cHelp

		PutSX1Help(cKey,aHelpPor,aHelpEng,aHelpSpa)

		MsUnlock()
	Else

		lPort := ! "?" $ X1_PERGUNT .And. ! Empty(SX1->X1_PERGUNT)
		lSpa := ! "?" $ X1_PERSPA .And. ! Empty(SX1->X1_PERSPA)
		lIngl := ! "?" $ X1_PERENG .And. ! Empty(SX1->X1_PERENG)

		If lPort .Or. lSpa .Or. lIngl
			RecLock("SX1",.F.)
			If lPort
				SX1->X1_PERGUNT:= Alltrim(SX1->X1_PERGUNT)+" ?"
			EndIf
			If lSpa
				SX1->X1_PERSPA := Alltrim(SX1->X1_PERSPA) +" ?"
			EndIf
			If lIngl
				SX1->X1_PERENG := Alltrim(SX1->X1_PERENG) +" ?"
			EndIf
			SX1->(MsUnLock())
		EndIf
	Endif

	RestArea( aArea )

Return
*/
