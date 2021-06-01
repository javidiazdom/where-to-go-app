class RatingDescriptionData {
  String name;
  String description;

  RatingDescriptionData(this.name, this.description);
}

List<RatingDescriptionData> descriptions = [
  new RatingDescriptionData("Calidad de la ventilación",
      "Valoración estimada de la calidad de la calidad de la ventilación como medida preventiva a la transmisión por aérea, basados en los aspectos evaluables según la OMS, que son la velocidad mínima del sistema de ventilación mecánico, la velocidad mínima de ventilación natural y la dirección de la corriente."),
  new RatingDescriptionData("Distanciamiento social",
      "Evaluación subjetiva de las medidas que se toman en las localizaciones para mantener la distancia de seguridad de los transeúntes en todo momento: vías delimitadas para cada dirección, control de aforos en espacios cerrados, indicaciones del personal para mantener la distancia de seguridad..."),
  new RatingDescriptionData("Facilidad del saneamiento de manos",
      "Valoración estimada de las medidas tomadas en las localizaciones para facilitar el saneamiento de manos a los asistentes, como medida preventiva para la transmisión por gotas y contacto directo. Se deben de tener en cuenta aspectos como la existencia de dispensadores de gel alcohólico, la frecuencia de éstos y la disposición de los encargados del lugar a incitar a los transeúntes al higienizado de las manos."),
  new RatingDescriptionData("Uso de mascarillas",
      "Evaluación estimada del uso de mascarillas generalizado de las personas de dicha localización, como medida preventiva para frenar la transmisión aérea. Los aspectos a tener en cuenta para la realización de la valoración serán el uso de la mascarilla por parte de los transeúntes, los empleados de la localización (si los hubiere) y las indicaciones del uso de mascarilla por parte de los encargados o empleados de la localización en caso de haberlos."),
  new RatingDescriptionData("Limpieza y desinfección del entorno",
      "Evaluación estimada de la calidad en la limpieza y desinfección del entorno como medida preventiva para la transmisión indirecta a través de objetos o superficies. Los criterios a tener en cuenta para la evaluación de este aspecto serán la frecuencia de limpieza por parte del personal de la localización si lo hubiere y la limpieza aparente del lugar."),
];
