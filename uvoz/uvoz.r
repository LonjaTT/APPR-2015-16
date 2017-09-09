# 2. faza: Uvoz podatkov

#Vektor z imeni regij:
regije <- c("Leto", "Pomurska", "Podravska", "Koroška", "Savinjska", "Zasavska", "Spodnjeposavska", "Jugovzhodna", "Osrednjeslovenska", "Gorenjska", "Notranjsko-kraška", "Goriška", "Obalno-kraška")

leta <- c("Obcina","2007", "2008", "2009","2010","2011","2012","2013","2014")

#Uvoz tabele s številom muzejev:
  
uvozi.stevilomuzejev <- function(){return(read.csv2("podatki/stmuzejevnapreb.csv", header = FALSE, na.strings = "...", row.names = 1, col.names = regije))
  }

#Uvoz procenta občasnih razstav:
  
uvozi.obcasne <- function(){return(read.csv2("podatki/obcasnerazsprocent.csv", header = FALSE, na.strings = "...", row.names = 1, col.names = regije))}

#Uvoz povprečnega števila obiskovalcev:
  
uvozi.obiskovalce <- function(){return(read.csv2("podatki/stobiskovalcev.csv", header = FALSE, na.strings = "...", row.names = 1, col.names = regije)) }
uvozi.muzeje <- function(){return(read.csv("podatki/muzejiinrazstavisca.csv", dec = ".", na.strings ="-", header = FALSE, row.names=1, col.names = leta))}

#Uvoz evrop. št. muzejev
uvozi.egmnapreb <- function(){return(read.csv2("podatki/egm-napreb.csv", dec = ",", header = FALSE, na.strings = "?", colClasses = c("NULL", NA, NA), row.names = drzave, col.names = imena2, skip = 1))}

#uvoz skupnega obiska za evropo
uvozi.evropa <- function(){return(read.csv2("podatki/egm-skupaj.csv", dec = ",", header = FALSE, na.strings = "", colClasses = c("NULL", NA, NA, "NULL", "NULL", "NULL", "NULL", "NULL"), row.names = drzave, col.names = imena3, skip = 1))}


#Zapišemo v tabelco:
  
stevilomuzejev2 <- uvozi.stevilomuzejev()
OK.vrstice1 <- apply(stevilomuzejev2, 1, function(x){!any(is.na(x))})
Ok.stevilomuzejev <- stevilomuzejev2[OK.vrstice1, ]




obcasnerazstave <- uvozi.obcasne()
OK.vrstice2 <- apply(obcasnerazstave, 1, function(x){!any(is.na(x))})
OK.obcasne <- obcasnerazstave[OK.vrstice2, ]

obcasne.tidy <- data.frame(leto = rownames(OK.obcasne),
                           OK.obcasne) %>%
  melt(variable.name = "regija", value.name = "stevilo")
obcasne.tidy2 <- arrange(obcasne.tidy, leto)

obiskovalci <-uvozi.obiskovalce()
OK.vrstice3 <- apply(obiskovalci, 1, function(x){!any(is.na(x))})
OK.obiskovalci <- obiskovalci[OK.vrstice3, ]

obiskovalci_tidy1 <- data.frame(Leto = rownames(OK.obiskovalci), OK.obiskovalci) %>% melt(variable.name = "Regija", value.name = "Stevilo")
obiskovalci_tidy2 <- arrange(obiskovalci_tidy1, Leto)

muzeji1<-uvozi.muzeje()
OK.vrstice4 <- apply(muzeji1, 1, function(x){!any(is.na(x))})
ok.muzeji <- muzeji1[OK.vrstice4, ]



stevilomuzejev <- read.csv2("podatki/stmuzejevnapreb.csv", dec =".", header = FALSE, na.strings = "...", col.names = regije)%>%melt(id.vars = "Leto", variable.name = "Regija", value.name = "Stevilo.muzejev")
stmuzejev <- arrange(stevilomuzejev, Leto)
stmuzejev2 <- drop_na(stmuzejev)
#obcasnerazstave <- read.csv2("podatki/obcasnerazsprocent.csv", dec = ".", header = FALSE, na.strings = "...", col.names = regije)%>%melt(id.vars = "Leto", variable.name = "Regija", value.name = "Obcasne.razstave")

obiskmuzejev <- read.csv2("podatki/stobiskovalcev.csv", dec = ".", header = FALSE, na.strings = "...", col.names = regije)%>%melt(id.vars = "Leto", variable.name = "Regija", value.name = "Obisk.muzejev")


skupaj <- stevilomuzejev %>% full_join(obiskmuzejev) 

imena2 <- c("Država", "Leto", "Muzeji na 100.000 prebivalcev")
drzave <- c("Avstrija", "Belorusija", "Belgija", "Bulgarija", "Hrvaška", "Češka", "Danska", "Estonija", "Finska", "Francija", "Nemčija", "Grčija", "Madžarska", "Irska", "Italija", "Latvija", "Litva", "Luksemburg", "Makedonija", "Norveška", "Poljska", "Portugalska", "Romunija", "Slovaška", "Slovenija", "Španija", "Švedska", "Švica", "Nizozemska", "Združeno Kraljestvo")
imena3 <- c("Država", "Leto", "Obisk.muzejev", "A", "B", "C", "D", "E")
#Uvozimo evropsko število muzejev na prebivalca
egmnapreb3 <- uvozi.egmnapreb()
ok.vrstice5 <- apply(egmnapreb3, 1, function(x){!any(is.na(x))})
ok.egmnapreb3 <- egmnapreb3[ok.vrstice5, ]

#Uvozim skupno število obiskov za evropo
egmskupaj2 <- uvozi.evropa()
ok.vrstice6 <- apply(egmskupaj2, 1, function(x){!any(is.na(x))})
ok.egmskupaj2 <- egmskupaj2[ok.vrstice6, ]

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
#uvozi.druzine <- function() {
  #return(read.table("podatki/druzine.csv", sep = ";", as.is = TRUE,
                      #row.names = 1,
                      #col.names = c("obcina", "en", "dva", "tri", "stiri"),
                      #fileEncoding = "Windows-1250"))
#}

# Zapišimo podatke v razpredelnico druzine.
#druzine <- uvozi.druzine()

#obcine <- uvozi.obcine()

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.
imena2 <- c("Država", "Leto", "Muzeji na 10.000 prebivalcev")
drzave <- c("Avstrija", "Belorusija", "Belgija", "Bulgarija", "Hrva?ka", "?e?ka", "Danska", "Estonija", "Finska", "Francija", "Nemčija", "Grčija", "Madžarska", "Irska", "Italija", "Latvija", "Litva", "Luksemburg", "Makedonija", "Norveška", "Poljska", "Portugalska", "Romunija", "Slovaška", "Slovenija", "Španija", "Švedska", "Švica", "Nizozemska", "Združeno Kraljestvo")
egmnapreb <- read.csv2("podatki/egm-napreb.csv", dec = ",", header = FALSE, na.strings = "", colClasses = c("NULL", NA, NA), row.names = drzave, 
                       col.names = imena2, skip = 1)
egmnapreb2 <- drop_na(egmnapreb)
