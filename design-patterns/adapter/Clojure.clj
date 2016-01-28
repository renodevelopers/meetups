;; Functions defined.
(defn book-open [title] (str title " opened."))
(defn book-turn-page [] "Turned page.")

;; Interfaces defined.
(defprotocol IPaperBook
  (open [this])
  (turn-page [this]))

(defprotocol IEBook
  (press-start [this])
  (press-next [this]))

;; Reader class defined. Uses the same protocol (interface) as EBook for brevity.
(deftype Kindle [book]
  IEBook
  (press-start [this] (press-start book))
  (press-next [this] (press-next book)))

;; Book classes defined and protocols added.
(deftype PaperBook [title]
  IPaperBook
  (open [this] (book-open title))
  (turn-page [this] (book-turn-page)))

(deftype EBook [title]
  IEBook
  (press-start [this] (book-open title))
  (press-next [this] (book-turn-page)))

;; IEBook interface extended to PaperBook class (the "adapter").
(extend-type PaperBook
  IEBook
  (press-start [this] (open this))
  (press-next [this] (turn-page this)))

;; DEMO
;; Books instantiated.
(def e-book (EBook. "Joy of Clojure"))
(def paper-book (PaperBook. "The Art of Computer Programming"))

;; Readers instantiated and used.
(def kindle-ebook (Kindle. e-book))
(press-start kindle-ebook)
;> "Joy of Clojure opened."
(press-next kindle-ebook)
;> "Turned page."

(def kindle-paper (Kindle. paper-book))
(press-start kindle-paper)
;> "The Art of Computer Programming opened."
(press-next kindle-paper)
;> "Turned page."
