## NPF funded project to communicate citizen science data to the public and land managers
## This app is specific to Acadia National Park, though the area of interest is easily changed


#### Starting up ####

## Functions
# Source the functions
source("00_app_functions.R")

## Data
# Read in the base data
the_data <- read.csv("www/datasets/the_data.csv") %>% 
  arrange(common.name)

# Images
images <- data.frame(src = list.files('www/img/obs')) %>%
  tidyr::separate(col = 'src', c('id', 'user', "img.num", "type"), sep = '_|\\.', remove = FALSE) %>%
  rowwise() %>%
  mutate(user = str_replace_all(user, "\\+", "_"),
         src = paste0("img/obs/", src)) %>% 
  arrange(img.num)

tdate <- today()

options(dplyr.summarise.inform = FALSE)




#### Shiny ui ####

ui <- fluidPage(
  
  ## SET UP
  tags$head(
    tags$link(type = "text/css", rel = "stylesheet", href = "css/style.css"),
    tags$meta(name = "viewport", content = "width=device-width, initial-scale=1.0"),
    tags$title("Saguaro National Park Citizen Science Explorer"),
    tags$script(src = "css/index.js", type = "module", "defer")
  ),

  ### BODY
  tags$body(
    
    ### Navigation
    tags$header(class = "primary-header",
     div(class = "logo-one",
         tags$img(src = "img/SchoodicInstitute_Horizontal_CMYK WHITE.png", alt = "Schoodic Institute at Acadia National Park",
                  class = "cs-logo")),
     div(class = "menu-nav-box",
         tags$nav(tags$ul(`aria-label` = "Primary navigation", role = "list",
                          tags$li(tags$a(href = "#", "Home")),
                          tags$li(tags$a(href = "#getinvolved", "Get Involved")),
                          tags$li(tags$a(href = "#summary", "Observation Summary")),
                          tags$li(tags$a(href = "#gallery", "Gallery")),
                          tags$li(tags$a(href = "#spex", "Species Explorer")),
                          tags$li(tags$a(href = "#about", "About"))))),
     tags$nav(class = "mobile-nav",
              tags$button(class = "nav-toggle",
                          span(class = "vegburger")),
              tags$ul(class = "nav-list", `aria-label` = "Mobile navigation",
                      tags$li(class = "nav-item", tags$a(href = "#", class = "nav-link", "Home")),
                      tags$li(class = "nav-item", tags$a(href = "#getinvolved", class = "nav-link", "Get Involved")),
                      tags$li(class = "nav-item", tags$a(href = "#summary", class = "nav-link", "Observation Summary")),
                      tags$li(class = "nav-item", tags$a(href = "#spex", class = "nav-link", "Species Explorer")),
                      tags$li(class = "nav-item", tags$a(href = "#gallery", class = "nav-link", "Gallery")),
                      tags$li(class = "nav-item", tags$a(href = "#about", class = "nav-link", "About"))))
    ),
    
    ## Home
    div(class = "titlebox",
       h1(textOutput("title"), class = "title-homepage"),
       h3("Citizen Science Explorer", class = "subtitle-homepage")
    ),
    div(class = "photo-cred",
        "Photo by Jack Brauer"),
    
    ## Science
    div(class = "spacer",
      div(class = "science-box",
          div(class = "anchors", id = "getinvolved"),
          div(class = "body-title-box",
            icon("microscope",  class = "body-box-icon"), 
            h4("Get Involved", class = "body-titles")),
        div(class = "scihead",
            h3("Get Involved in Our Science")),
        div(class = "science-content-1",
            img(src = "img/stinknet.jpg", alt = "A photo showing lots of stinknet in bloom with yellow flowers", class = "science-img"),
            div(class = "science-text purp",
                h3("Startling Stinknet"),
                h4("Stinknet is an alarming invasive plant that threatens our communities by destroying biodiversity 
                   with its aggressive growth, causing fires when the plants dry, emitting toxic gases when burned, and causing 
                   allergic reactions for some people. Stinknet is currently invading the Tucson area, and we need your help 
                   finding and removing it."),
                h4("Scan the QR code to learn more or to report stinknet:", img(src = "img/stinknet_QR.png", class = "qrimg")),
                )),
        div(class = "science-content-2",
            div(class = "rep-imgs",
              img(src = "img/rarerep.jpg", alt = "A red, black, and yellow snake on rocky substrate", class = "rep-snk"),
              img(src = "img/inat_QR.png", class = "qrimg-rep")),
            div(class = "science-text green",
                h3("Rare Reptiles"),
                h4("Saguaro National Park is a reptile and amphibian paradise! We have nearly 50 species, but many are quite rare or spent most of their lives underground. If you’ve seen a saddled leaf-nosed snake, western ground snake, or glossy snake lately, lucky you, because our biologists rarely do!"),
                h4("Knowing what species are in the park and where they occur is of great value for conserving these amazing reptiles for future generations, so please take photos of every snake you see – just don’t get too close to the ones with rattles. We are also interested in photos of Desert Box turtles and long-nosed leopard lizards, both of which are very rare in the park’s east district."),
                h4("Please help us by uploading any photos you take of reptiles and amphibians to iNaturalist. Download the free app by scanning the QR code to the left."),
                )),
        div(class = "science-content-3",
            img(src = "img/saguarobloom.jpg", alt = "A photo take from above capturing the white blossums of a Saguaro Cactus", class = "science-img"),
            div(class = "science-text purp",
                h3("Saguaro Blooms"),
                h4("Saguaros always bloom in late spring, during May and June – except when they don’t. Late fall and winter flowers on saguaros are quite unusual, but sometimes – as in 2020 – the park sees large fall blooms, for reasons scientists don’t understand. These flowers are pollinated and turn into bright red fruits that ripen as late as January."),
                h4("If you see a saguaro blooming during the months of September through March, please be a citizen scientist and take a photo of it! These records are valuable for long-term research on how saguaros are adapting to warming temperatures in the Sonoran Desert."),
                h4("You can upload any saguaro flower photos to iNaturalist:", img(src = "img/inat_QR.png", class = "qrimg"))))
    )),
    
    # ## Intro
    # div(class = "spacer",
    #     div(class = "intro-box",
    #         div(class = "anchors",  id = "intro"),
    #         div(class = "body-title-box",
    #             icon("book-open",  class = "body-box-icon"), 
    #             h4("Introduction", class = "body-titles")),
    #         div(class = "intro-content",
    #             div(class = "intro-text",
    #                 h2("Welcome to the Saguaro National Park citizen science explorer!"),
    #                 h3("This display summarizes iNaturalist and eBird records from the past week in Saguaro National Park. In addition to this summary, we've highlighted some recent science that has been made possible by citizen science participation in our work here at the park. To get involved with one of our projects, ask a ranger in the Visitor Center or visit our website!")),
    #             img(src = "img/citsci.png", alt = "A group of citizen scientists collecting data
    #                 on a saguaro catcus", class = "citsci-image"),
    #             img(src = "img/citsci2.png", alt = "A group of citizen scientists collecting data
    #                 on a saguaro catcus", class = "citsci-image-2"),
    #             )
    # )),
    
    ## Data summary
    div(class = "summary-box", 
        div(class = "anchors", id = "summary"),
        div(class = "body-title-box",
            icon("table",  class = "body-box-icon"), 
            h4("Citizen Science Observation Summary", class = "body-titles")),
        div(class = "inat-box", 
            img(src = "img/inat.png", alt = "iNaturalist", class = "obs-logos"),
            div(class = "sep-line"),
            div(class = "inat-display-grid",
                
                div(class = "observers-format",
                    h4(tags$b("Observers")),
                    icon("users"),
                    h2(textOutput("total_observers"), class = "summary-stat-text")),
                div(class = "observations-format",
                    h4(tags$b("Observations")),
                    icon("camera-retro"),
                    h2(textOutput("total_observations"), class = "summary-stat-text")),
                div(class = "comgroup-format",
                    h4(tags$b("Most Common Group")),
                    icon("bacteria"),
                    h2(textOutput("top_taxa"), class = "summary-stat-text")),
                div(class = "comsp-format",
                    h4(tags$b("Most Common Species")),
                    icon("leaf"),
                    h2(textOutput("top_sp"), class = "summary-stat-text")),
                )),
        div(class = "ebird-box",
            img(src = "img/ebird.png", alt = "eBird", class = "obs-logos"),
            div(class = "sep-line"),
            div(class = "ebird-display-grid",
                div(class = "observers-format",
                    h4(tags$b("Checklists")),
                    icon("list-check"),
                    h2(textOutput("total_checklists_e"), class = "summary-stat-text")),
                div(class = "observations-format",
                    h4(tags$b("Total Species")),
                    icon("feather"),
                    h2(textOutput("total_sp_e"), class = "summary-stat-text")),
                div(class = "comgroup-format",
                    h4(tags$b("Total Individuals")),
                    icon("binoculars"),
                    h2(textOutput("total_birds_e"), class = "summary-stat-text")),
                div(class = "comsp-format",
                    h4(tags$b("Most Common Species")),
                    icon("crow"),
                    h2(textOutput("top_sp_e"), class = "summary-stat-text")),
                )),
    ),
    
    ## Gallery
    div(class = "box-photo-gallery",
        div(class = "anchors", id = "gallery"),
        div(class = "body-title-box",
            icon("image",  class = "body-box-icon"),
            h4("Photo Gallery", class = "body-titles")),
        div(class = "grid-wrapper",
            div(tabindex = 0, class = ifelse(length(images$src) < 1, "no-imgs", "hidden"),
                img(src = "img/ice.jpg"),
                div(class = "no-photos",
                    h3("No research grade photos this week."),
                    h3("Go take some!"))),
            div(tabindex = 0, class = ifelse(length(images$src) >= 1, "img-container", "hidden"),
                img(src = images$src[1], alt = images$id[1]),
                div(class = "img-label",
                    h3(images$id[1]),
                    h4("©", images$user[1]))),
            div(tabindex = 0, class = ifelse(length(images$src) >= 2, "img-container", "hidden"),
                img(src = images$src[2], alt = images$id[2]),
                div(class = "img-label",
                    h3(images$id[2]),
                    h4("©", images$user[2]))),
            div(tabindex = 0, class = ifelse(length(images$src) >= 3, "img-container", "hidden"),
                img(src = images$src[3], alt = images$id[3]),
                div(class = "img-label",
                    h3(images$id[3]),
                    h4("©", images$user[3]))),
            div(tabindex = 0, class = ifelse(length(images$src) >= 4, "img-container", "hidden"),
                img(src = images$src[4], alt = images$id[4]),
                div(class = "img-label",
                    h3(images$id[4]),
                    h4("©", images$user[4]))),
            div(tabindex = 0, class = ifelse(length(images$src) >= 5, "img-container", "hidden"),
                img(src = images$src[5], alt = images$id[5]),
                div(class = "img-label",
                    h3(images$id[5]),
                    h4("©", images$user[5]))),
            div(tabindex = 0, class = ifelse(length(images$src) >= 6, "img-container", "hidden"),
                img(src = images$src[6], alt = images$id[6]),
                div(class = "img-label",
                    h3(images$id[6]),
                    h4("©", images$user[6]))),
            div(tabindex = 0, class = ifelse(length(images$src) >= 7, "img-container", "hidden"),
                img(src = images$src[7], alt = images$id[7]),
                div(class = "img-label",
                    h3(images$id[7]),
                    h4("©", images$user[7]))),
            div(tabindex = 0, class = ifelse(length(images$src) >= 8, "img-container", "hidden"),
                img(src = images$src[8], alt = images$id[8]),
                div(class = "img-label",
                    h3(images$id[8]),
                    h4("©", images$user[8]))),
            div(tabindex = 0, class = ifelse(length(images$src) >= 9, "img-container", "hidden"),
                img(src = images$src[9], alt = images$id[9]),
                div(class = "img-label",
                    h3(images$id[9]),
                    h4("©", images$user[9])))
        )
    ),

    ## Species explorer
    div(class = "spex-box",
        div(class = "anchors", id = "spex"),
        div(class = "body-title-box",
            icon("tree",  class = "body-box-icon"), 
            h4("Species Explorer", class = "body-titles")),
        div(class = "picker-box",
            pickerInput("spselect",
                        label = "Select a species:",
                        choices = unique(the_data$common.name),
                        options = list(`live-search` = TRUE,
                                       size = 20,
                                       header = "Search Menu"),
                        selected = unique(the_data$common.name)[1],
                        width = "100%",
                        multiple = FALSE)),
          div(class = "map-box",
              leafletOutput("reactspmap", height = "100%"),
              ),
          div(class = "data-table-box",
              h3("Explore the past week's data"),
              div(class = "dattab", 
                  DT::dataTableOutput("tableout")),
              h4("Data from iNaturalist and eBird and modified by Schoodic Institute at Acadia National Park.")
        )),

    
    ## About
    div(class = "about-grid-box",
        div(class = "anchors", id = "about"),
        div(class = "body-title-box",
            icon("circle-info",  class = "body-box-icon"),
            h4("About This Page", class = "body-titles")),
        div(class = "about-info-box",
            h4("Land Acknowledgement Statement"),
            "The observations summarized here are from across the homeland of the BLANK.",
            br(),
            h4("Background"),
            "There is a wealth of scientific data collected by citizen scientists that exists 
            in protected areas like national parks. These data have generally not been leveraged 
            to inform park management or summarized and communicated back out to the park visitors 
            who helped collect the data. This project was created to address these points and assess 
            the biodiversity of national parks through building a citizen science data
            workflow that is transferable across protected areas.",
            br(),
            h4("Partners"),
            h3("Schoodic Institute"),
            "Established in 2004, Schoodic Institute at Acadia National Park is a 501(c)(3) nonprofit
            organization and a partner in science and education of the National Park Service. Based at the
            largest National Park Service Research Learning Center in Winter Harbor, Maine, in
            Wabanaki homeland, Schoodic Institute’s focus is understanding environmental change taking
            place in Acadia and beyond, and helping managers of parks and other protected areas respond
            and adapt to change while engaging people of all ages in science. For more information, please visit www.schoodicinstitute.org.",
            br(),
            br(),
            h3("Friends of Saguaro National Park"),
            "Friends of Saguaro National Park is the not-for-profit fundraising partner of the National Park Service at Tucson's Saguaro National Park, working to help the public through three initiatives:",
            tags$ul(style = "padding-left: 40px;",
            tags$li("Discover Saguaro - by reconnecting children and nature, and encouraging the exploration and discovery of the resources, heritage and recreational opportunities of the Park"),
            tags$li("Protect Saguaro - by assisting the preservation and conservation of the natural and cultural resources of the Park, and sustaining its wilderness character"),
            tags$li("Support Saguaro - by strengthening community partnerships, and building environmental stewardship through philanthropy, public education, and volunteerism"),
            tags$li("For more information, please visit www.friendsofsaguaro.org")),
            br(),
            h3("Western National Parks"),
            "What Does Western National Parks do? As a nonprofit education partner of the National Park Service, WNP supports 72 parks across the West, developing products, services, and programs that enrich the visitor experience.",
            tags$ul(style = "padding-left: 40px;",
            tags$li("Western National Parks' Commitment: National parks tell the story of America, embodying its beauty, culture, and heritage. WNP helps discover, preserve, and share that story. But the American story is rapidly unfolding. In today's fast-paced, ever-changing world, WNP is committed to discovery: new knowledge, new understanding, and new ways to engage with society."),
            tags$li("Contact: WNP is based in Tucson, Arizona. Our home office adjoins the National Parks Store, situated at the foot of the Santa Catalina Mountains in the heart of the Sonoran Desert."),
            tags$li("For more information, please visit www.wnpa.org")),
            h4("Get in Touch!"),
            "If you are interested in a product like this for a protected area near you, or if you have 
            any questions about this product, please contact Kyle Lima at klima@schoodicinstitute.org.",
            h5(textOutput("today")))
        ),
        
    ## Footer
    tags$footer(
      div(class = "footer-box",
        HTML(
           '<div class = "footer-content">
            <div class = "footer-si">
            <img src = "img/SchoodicInstitute_Horizontal_CMYK.png" role = "img" aria-label = "Schoodic Institute at Acadia National Park logo" class = "footer-logo">
            <p><i>Our Mission is inspiring science, learning, and community for a changing world.</i></p>
            </div>
            <div>
            <p><a href = "#">Home</a></p>
            <p><a href = "#getinvolved">Get Involved</a></p>
            </div>
            <div>
            <p><a href = "#summary">Observation Summary</a></p>
            <p><a href = "#gallery">Gallery</a></p>
            </div>
            <div>
            <p><a href = "#spex">Species Explorer</a></p>
            <p><a href = "#about">About</a></p>
            </div>
            </div>'),
      div(class = "copyright",
          p(textOutput("copyright_txt"))
          )
      )
    )
  )
)







### SHINY SERVER ###

server <- function(input, output, session) {
  
  ## Title page header
  output$title <- renderText("Saguaro National Park")
  
  ## Leaflet for eBird obs
  output$emap <- renderLeaflet({ 
    leaflet_summary(the_data %>% filter(source == "eBird"))
  })
  
  ## Leaflet for eBird obs
  output$imap <- renderLeaflet({ 
    leaflet_summary(the_data %>% filter(source == "iNaturalist"))
  })
  
  ## Pie Chart
  output$percentplot <- renderPlot({
    the_data %>%
      group_by(source) %>% 
      summarise(count = length(source)) %>% 
      mutate(category = "citsci",
             percent = round((count/sum(count)*100), 0)) %>%
      ggplot(aes(x = category, y = percent, fill = source)) +
      geom_col() + 
      coord_flip() +
      guides(fill = guide_legend(reverse = TRUE)) +
      geom_text(aes(x = category, y = percent, label = percent, group = source),
                position = position_stack(vjust = 0.5), size = 7, color = "#eae7e7") +
      scale_fill_manual(values = c("#0d042ad9", "#0c3e13d9")) +
      theme_minimal() +
      theme(axis.title = element_blank(),
            axis.text = element_blank(),
            plot.background = element_blank(),
            panel.background = element_blank(),
            panel.grid = element_blank(),
            legend.background = element_blank(),
            legend.title = element_blank(),
            legend.text = element_text(size = 20, color = "black"),
            legend.key.size = unit(1, "cm"),
            legend.spacing.x = unit(1, "cm"),
            legend.position = "bottom")
  }, bg = "transparent")
  
  
  ## Reactive data frame for Species Explorer tab
  speciesreact <- reactive({
    the_data %>%
      filter(common.name == input$spselect)
  })
  
  ## Reactive map to display species obs for Species Explorer tab - uses species_reactive_db
  output$reactspmap <- renderLeaflet({ 
    species_leaflet(speciesreact())
  })
  
  ### iNat
  ## Text output for the top recorded species
  output$top_sp <- renderText({
    species <- the_data %>% 
      filter(source == "iNaturalist") %>% 
      group_by(scientific.name, common.name) %>%
      summarise(count = length(user.id)) %>%
      arrange(desc(count))
      
    paste(species$common.name[1])
          #, " (", species$count[1], " observations)")
  })
  
  ## Text output for the group with the most observations
  output$top_taxa <- renderText({
    taxon <- the_data %>%
      filter(source == "iNaturalist") %>% 
      group_by(iconic.taxon.name) %>%
      summarise(count = length(iconic.taxon.name)) %>%
      arrange(desc(count))
    
    paste(taxon$iconic.taxon.name[1])
          #" (", taxon$count[1], " observations)")
  })
  
  ## Text output for the number of total observers
  output$total_observers <- renderText({
    observers <- the_data %>%
      filter(source == "iNaturalist") %>% 
      group_by(user.id, user.login) %>%
      summarise(count = length(user.id)) %>%
      arrange(desc(count))
    
    paste0(length(observers$user.id))
  })
  
  ## Total observations
  output$total_observations <- renderText({
    observers <- the_data %>%
      filter(source == "iNaturalist") %>% 
      group_by(user.id, user.login) %>%
      summarise(count = length(user.id)) %>%
      arrange(desc(count))
    
    paste0(sum(observers$count))
  })
  
  ### eBird
  ## Text output for the top recorded species
  output$top_sp_e <- renderText({
    species <- tibble(the_data) %>% 
      filter(source == "eBird") %>% 
      group_by(scientific.name, common.name) %>%
      summarise(count = length(common.name)) %>%
      arrange(desc(count))
    
    paste(species$common.name[1])
  })
  
  ## Text output for the group with the most observations
  output$total_sp_e <- renderText({
    taxon <- the_data %>%
      filter(source == "eBird") %>% 
      group_by(common.name) %>%
      summarise(count = length(common.name)) %>% 
      arrange(desc(count))
    
    paste(length(taxon$common.name))
  })
  
  ## Text output for the number of total checklists
  output$total_checklists_e <- renderText({
    observers <- the_data %>%
      filter(source == "eBird") %>% 
      group_by(checklist) %>%
      summarise(count = length(unique(checklist))) %>%
      arrange(desc(count))
    
    paste(length(observers$checklist))
  })
  
  ## Text output for the number of total birds
  output$total_birds_e <- renderText({
    obs <- the_data %>%
      filter(source == "eBird") %>% 
      mutate(count = replace(count, is.na(count), 1))
    
    paste(sum(obs$count))
  })
  
  ## Data table for display
  output$tableout <- DT::renderDataTable({
    dat <- tibble(the_data) %>% 
      select(scientific.name, common.name, observed.on, place.guess, source)
    
    DT::datatable(dat, options = list(pageLength = 10, dom = 'Brtip', scrollX = TRUE),
                  rownames = FALSE, filter = 'top', colnames = c("Scientific name", 
                  "Common name", "Date observed", "Location", "Data source"))
  })
  
  
  # ## Text output for species of interest description
  # output$descrip_sp <- renderText({
  #   "Scientists at Acadia National Park are using your eBird and iNaturalist observations
  #        to find out when and where certain species are being seen. We have compiled a list of 
  #        species that are important to park managers. If they are reported by people like you,
  #        our program summarizes and reports that information to park managers."
  # })

  # ## Text output for new park species
  # output$newsp <- renderText({
  #   if (length(new_species$scientific.name) >= 1) {
  #     return(paste0("There were ", length(unique(new_species$scientific.name)), " species recorded 
  #                   in the last 7 days that have not been recorded in the park before."))
  #   } else {
  #     return(paste0("There were no species recorded in the last 7 days that have not been 
  #                   recorded in the park before."))
  #   }
  # })
  # 
  # ## Text output for T/E species
  # output$te <- renderText({
  #   if (length(te_species$scientific.name) >= 1) {
  #     return(paste0("There were ", length(unique(te_species$scientific.name)), " species recorded 
  #                   in the last 7 days that have not been recorded in the park before."))
  #   } else {
  #     return(paste0("There were no species recorded in the last 7 days that have not been 
  #                   recorded in the park before."))
  #   }
  # })
  # 
  # ## Text for rare species
  # output$rare <- renderText({
  #   if (length(rare_species$scientific.name) >= 1) {
  #     return(paste0("There were ", length(unique(rare_species$scientific.name)), " species recorded 
  #                   in the last 7 days that have not been recorded in the park before."))
  #   } else {
  #     return(paste0("There were no species recorded in the last 7 days that have not been 
  #                   recorded in the park before."))
  #   }
  # })
  # 
  # ## Text for invasives and pests
  # output$invasive <- renderText({
  #   if (length(invasive_species$scientific.name) >= 1) {
  #     return(paste0("There were ", length(unique(invasive_species$scientific.name)), 
  #                   " invasive and/or pest species recorded in the last 7 days."))
  #   } else {
  #     return(paste0("There were no invasive or pest species recorded in the last 7 days 
  #                   in the park."))
  #   }
  # })
  
  ## Text for today's date
  output$today <- renderText({
    date <- today()
    date <- format(date, "%B %d, %Y")
    paste0("Last updated: ", date)
  })
  
  ## Output to download data as a CSV
  output$downloadCsv <- downloadHandler(
    filename = function() {
      paste0("anp_citsci_data_", str_replace_all(today(), "-", ""), ".csv")
    },
    content = function(file) {
      inat_data_download = the_data %>% select(-user.id)
      
      write.csv(inat_data_download, file, row.names = F)
    })
  
  ## Copyright text
  output$copyright_txt <- renderText({
    date <- today()
    paste0("© ", year(date), " Schoodic Institute at Acadia National Park")
  })
  
}



#### Run the app ####

shinyApp(ui, server)



