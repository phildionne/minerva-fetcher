# Minerva Fetcher

```ruby
request = Minerva::Fetcher.request(Minerva::Fetcher::Query.new(title: "Mesmerise", artist: "Temples"), Minerva::Fetcher::Strategies::Soundcloud.new)
# => #<Minerva::Fetcher::Request ...>

request.query
# => #<Minerva::Fetcher::Query ...>

request.strategy
# => #<Minerva::Fetcher::Strategies::Soundcloud ...>

results = request.fetch
request.results
# => [...]

result = results.first
result.title
result.genre
result.description
result.release_date

results.first.to_hash
# => {...}
```


## Strategies

### Acoustid

__Required:__ `fingerprint`

```ruby
Minerva::Fetcher.request(Query.new(fingerprint: "3JsdJsGgSH182JAaSH..."), Strategies::Acoustid.new)
```

Generage a fingerprint using [chromaprint](http://acoustid.org/chromaprint) (`fpcalc` cli name).

[Reference](http://acoustid.org/webservice#lookup)

---

### Discogs

__Required:__ `release`
__Optional:__ `artist`

```ruby
Minerva::Fetcher.request(Query.new(release: "Sun Structures", artist: "Temples"), Strategies::Discogs.new)
```

[Reference](http://www.discogs.com/developers/resources/database/search-endpoint.html)

---

### Echonest

__Required:__ `fingerprint`

```ruby
Minerva::Fetcher.request(Query.new(fingerprint: "1jHsh3h23KShsh2..."), Strategies::Echonest.new)
```
Generage a fingerprint using [echoprint-codegen](https://github.com/echonest/echoprint-codegen) (`echoprint-codegen` cli name).

[Reference](http://developer.echonest.com/docs/v4/song.html#identify)

---

### Last.fm

__Required:__ `title`
__Optional:__ `artist`

```ruby
Minerva::Fetcher.request(Query.new(title: "Mesmerise", artist: "Temples"), Strategies::Lastfm.new)
```

[Reference](http://www.lastfm.fr/api/show/track.search)

---

### Musicbrainz

__Required:__ `title`
__Optional:__ `artist`

```ruby
Minerva::Fetcher.request(Query.new(title: "Mesmerise", artist: "Temples"), Strategies::Musicbrainz.new)
```

[Reference](http://musicbrainz.org/doc/Development/XML_Web_Service/Version_1#Searching_Tracks)

---

### Soundcloud

__Required:__ `title`
__Optional:__ `artist`

```ruby
Minerva::Fetcher.request(Query.new(title: "Mesmerise", artist: "Temples"), Strategies::Soundcloud.new)
```

[Reference](http://developers.soundcloud.com/docs/api/reference#tracks)
