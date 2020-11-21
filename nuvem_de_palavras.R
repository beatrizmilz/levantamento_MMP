library(tm)
library(wordcloud2)
library(tidytext)


# 
# url <- "https://docs.google.com/spreadsheets/d/1oEd1bktywsgeZoRRD3SdrM8zuxMdYwa9oBgN2cknbUM/edit?usp=sharing"
# 
# base_raw <- googlesheets4::read_sheet(url)

stop_words_pt <-  tibble::tibble(word = tm::stopwords("pt")) %>% 
  tibble::add_row(word = "macrometrópole") %>% 
  tibble::add_row(word = "paulista")


palavras <- base_raw %>% 
  dplyr::select(titulo) %>% 
  tidytext::unnest_tokens(word, titulo) %>% 
  dplyr::anti_join(stop_words_pt) %>% 
  dplyr::count(word, sort = TRUE) %>% 
  tibble::as_tibble() 


contorno_mmp <- "imagens/contorno_mmp.png"
nuvem <- wordcloud2::wordcloud2(palavras, figPath = contorno_mmp, size = 0.7 )
nuvem
# Tive que tirar print da nuvem no IE. O pacote tá com algum bug no figPath!


# library(webshot)
# #webshot::install_phantomjs()
# # save it in html
# library("htmlwidgets")
# saveWidget(nuvem,"tmp.html",selfcontained = F)
# # and in png
# webshot("tmp.html","imagens/nuvem_titulos_webshot.png", delay =5, vwidth = 1000, vheight=1000) # changed to png. 
