function randomString(nbCharacters) {
    var text = '';
    var possible = 'abcdefghijklmnñopqrstuvwxyz0123456789';
    for(var i = 0; i < nbCharacters; i++) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    }

    return text
}
