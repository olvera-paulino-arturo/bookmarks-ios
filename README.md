# Bookmarks SwiftUI

- Requiere el uso de **SFSymbols**
  > [SFSymbols](https://developer.apple.com/sf-symbols/)
- Las clases de BookmarksModel CoreData deben de ser generadas manualmente en caso de que den error.
- El fichero GoogleService-Info.plist ya esta incluido dentro de:
  > SupportingFiles/GoogleService
- El fichero xcworkspace **bookmarks.xcworkspace** se genera desde su local ejecutando:
  >  pod install
- Se eliminó Apollo para GraphQL debido a la complejidad de no poder automatizar la instalación CLI que requiere node y algunos extras con un script. Las consultas GraphQL ahora se realizan a través de **URLSession**.
