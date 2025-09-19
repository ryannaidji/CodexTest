# SimpleLockWidget

SimpleLockWidget est une application iOS écrite en SwiftUI qui permet d'afficher un texte personnalisé dans un widget de l'écran verrouillé (lock screen). L'application principale permet de modifier le texte et de demander une actualisation immédiate du widget.

## Fonctionnalités

- Interface simple pour saisir le texte à afficher.
- Synchronisation du message entre l'application et le widget via App Groups.
- Widget de l'écran verrouillé compatible avec les familles inline, rectangulaire et circulaire.
- Aperçu rapide du rendu directement dans l'application.

## Structure du projet

Le projet est fourni sous la forme d'un package Swift qui peut être ouvert directement dans Xcode :

- `Package.swift` : configuration du package, de l'application iOS et de l'extension widget.
- `Sources/Shared` : constantes partagées entre l'application et le widget.
- `Sources/AppModule` : code de l'application iOS (interface utilisateur, stockage du texte, aperçu).
- `Sources/LockScreenWidget` : code du widget et de son fournisseur de timeline.

## Prérequis

- Xcode 14 ou version ultérieure.
- iOS 16 ou version ultérieure pour exécuter le widget d'écran verrouillé.

## Installation

1. Ouvrez `Package.swift` dans Xcode (`File > Open...`).
2. Lorsque le projet est chargé, sélectionnez la cible **SimpleLockWidget**.
3. Dans les réglages de la cible, remplacez l'identifiant d'équipe (`ABCDE12345`) et l'identifiant d'application (`com.example.simplelockwidget`) par vos propres identifiants si nécessaire.
4. Assurez-vous que l'identifiant du groupe d'applications (`group.com.example.simplelockwidget`) est créé dans votre compte développeur Apple et associé à la cible de l'application et du widget.
5. Construisez et exécutez l'application sur un appareil ou simulateur iOS 16 ou supérieur.

## Utilisation

1. Lancez l'application et saisissez le texte souhaité.
2. Attendez quelques instants que le widget se mette à jour automatiquement, ou appuyez sur **Forcer la mise à jour du widget** pour accélérer le rafraîchissement.
3. Ajoutez le widget « SimpleLockWidget » à l'écran verrouillé (en mode personnalisation de l'écran verrouillé sur iOS 16).

## Personnalisation

- Modifiez la constante `SharedConstants.defaultMessage` pour changer le message par défaut.
- Adaptez la vue `LockScreenWidgetEntryView` si vous souhaitez un style différent selon les familles de widgets.

## Licence

Ce projet est fourni à titre d'exemple pédagogique et peut être utilisé librement.
