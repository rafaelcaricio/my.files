# Dotfiles of rafaelcaricio

This is my current setup environment for coding. Most of that is
personal configurations that probably is not very useful to anyone
else unless just for reference.

## Spotify client configuration

Create a file `~/.spotify-el` with the
[client key and id](https://github.com/rafaelcaricio/spotify.el#creating-the-spotify-app)
as:

``` shell
client-id=...
client-secret=...
```

Clone the repo *"https://github.com/rafaelcaricio/spotify.el.git"*
under `~/development/spotify.el`.

This is expected to make the Spotify client inside Emacs work
properly.  Then you can run `M-x spotify-connect` and a browser window
will open to approve the client connection via OAuth2.
