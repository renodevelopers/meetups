(ns patterns.decorator.core
  (:require [clojure.data.json :as json]
            [clojure.string :as str]
            [patterns.util :refer [to-xml]]))

;; Record impl
(defprotocol IRenderable
  (render [this]))

(defrecord WebService [data]
  IRenderable
  (render [_] data)

(defrecord RenderInXml [service]
  IRenderable
  (render [_] (to-xml (render service))))

(defrecord RenderInJson [service]
  IRenderable
  (render [_] (json/write-json (render service))))

(def serv (->WebService {"foo" "bar"}))
(def xml-serv (->RenderInXml serv))
(def json-serv (->RenderInJson serv))

;; Method dispatch impl
(defmulti render :render-type)

(defmethod render :xml
  [{:keys [data]}]
  (to-xml data))

(defmethod render :json
  [{:keys [data]}]
  (json/write-json data))

(defmethod render :default
  [{:keys [data]}]
  data)

(defn render-in
  [data render-type]
  (assoc data :render-type render-type))

(def serv {:data {"foo" "bar"}})
(def xml-serv (render-in serv :xml))
(def json-serv (render-in serv :json))

;; Usage - Same for both impl
(render xml-serv)
;> '<foo>bar</foo>'

(render json-serv)
;> '{"foo":"bar"}'
