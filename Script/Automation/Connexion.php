<?php
session_start();
$servername = "localhost";
$username = "votre_utilisateur";
$password = "votre_mot_de_passe";
$dbname = "votre_base_de_donnees";

// Créez une connexion à la base de données
$mysqli = new mysqli($servername, $username, $password, $dbname);

// Vérifiez la connexion
if ($mysqli->connect_error) {
    die("Échec de la connexion à la base de données : " . $mysqli->connect_error);
}

// Supposons que vous avez récupéré le nom d'utilisateur et le mot de passe depuis un formulaire.
$nomUtilisateur = $_POST['nom_utilisateur'];
$motDePasseSaisi = $_POST['mot_de_passe'];

// Exécutez la requête SQL pour récupérer l'utilisateur en fonction de son nom d'utilisateur.
$sql = "SELECT * FROM utilisateurs WHERE nom_utilisateur = '" . $nomUtilisateur . "'";
$result = $mysqli->query($sql);

if ($result && $result->num_rows > 0) {
    $utilisateur = $result->fetch_assoc(); // Récupère les données de l'utilisateur sous forme de tableau associatif

    // Maintenant, vérifiez si le mot de passe saisi correspond au mot de passe stocké dans la base de données.
    if (password_verify($motDePasseSaisi, $utilisateur['mot_de_passe'])) {
        // Le mot de passe est correct.
        echo "Mot de passe correct.";
        // Vous pouvez rediriger l'utilisateur vers une page appropriée ici.
    } else {
        // Le mot de passe est incorrect.
        echo "Mot de passe incorrect.";
        // Vous pouvez afficher un message d'erreur ou effectuer une autre action.
    }
} else {
    echo "Aucun utilisateur trouvé avec ce nom d'utilisateur.";
}
?>
