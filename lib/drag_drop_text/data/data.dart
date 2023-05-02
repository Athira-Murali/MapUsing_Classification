enum ClimateType { summer, winter }

class Climate {
  final String? name;
  final ClimateType? type;

  Climate({this.name, this.type});
}

final allClimate = [
  Climate(type: ClimateType.summer, name: "sun-glass"),
  Climate(type: ClimateType.winter, name: "woolen clothes"),
  Climate(type: ClimateType.summer, name: "ice-cream"),
  Climate(type: ClimateType.winter, name: "raincoats"),
  Climate(type: ClimateType.summer, name: "cotton clothes"),
  Climate(type: ClimateType.winter, name: "sweater"),
  Climate(type: ClimateType.summer, name: "cool-drinks"),
  Climate(type: ClimateType.winter, name: "umbrella")
];

Map<String, List<String>> myMap = {
  'fruit': [
    'apple',
    'banana',
    'orange',
  ],
  'vegetable': [
    'carrot',
    'broccoli',
    'tomato',
  ]
};
