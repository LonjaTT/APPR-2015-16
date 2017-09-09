# 4. faza: Analiza podatkov


obiskovalci.tidy <- data.frame(leto = rownames(OK.obiskovalci),
                               OK.obiskovalci) %>%
  melt(variable.name = "regija", value.name = "stevilo")

graf <- ggplot(obiskovalci.tidy, aes(x = leto, y = stevilo,
                             group = regija, color = regija)) +
  geom_line() + geom_point() + ggtitle("Obiskovalci") +
  xlab("Leta") + ylab("Skupaj")

#plot(graf)

istoleto <- c("Slovenija", "Italija", "Norveška", "Madžarska")
stevilo2013 <- matrix(c(3558551/100000, 38190401/100000, 10944898/100000, 9133600/100000),ncol=1,byrow=TRUE)
tabelca2 <- data.frame(stevilo2013, row.names = istoleto)
<<<<<<< HEAD
graf3 <- ggplot(tabelca2, aes(x = istoleto, y = stevilo2013)) + geom_col() +ggtitle("Obiskovalci v letu 2013 v nekaterih evropskih državah") +xlab("Države") + ylab("Število (v 100.000)")
#plot(graf3)
=======
graf3 <- ggplot(tabelca2, aes(x = istoleto, y = stevilo2013)) + geom_point() +ggtitle("Obiskovalci v letu 2013") +xlab("Države") + ylab("Število")
#plot(graf3)

obcasne.tidy <- data.frame(leto = rownames(OK.obcasne),
                               OK.obcasne) %>%
  melt(variable.name = "regija", value.name = "stevilo")

graf2 <- ggplot(obcasne.tidy, aes(x = leto, y = stevilo,
                                     group = regija, color = regija)) +
  geom_line() + geom_point() + ggtitle("Občasne razstave") +
  xlab("Leta") + ylab("Skupaj")
>>>>>>> 4e187c062aa5685c756febb37522ed37e294a3df

graf2 <- ggplot(obcasne.tidy, aes(x = leto, y = stevilo, group = regija, color = regija)) + geom_line() +
  geom_point() + ggtitle("Procent občasnih razstav") + xlab("Leto") + ylab("Skupaj")
#plot(graf2)




