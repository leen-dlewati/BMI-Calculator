import 'package:bmi_calculator/calculator_brain.dart';
import 'package:bmi_calculator/screens/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/reusable_card.dart';
import '../components/icon_content.dart';
import '../constants.dart';
import '../components/round_icon_button.dart';
import '../components/bottom_button.dart';

enum Gender { Male, Female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Color maleCardColor = kInactiveCardColor;
  Color femaleCardColor = kInactiveCardColor;
  Gender selectedGender;
  int height = 120;
  int weight = 60;
  int age = 12;
  void changeNumber(IconData selectedIcon, int number) {
    print(number);
    setState(() {
      if (selectedIcon == FontAwesomeIcons.plus) {
        if (number == weight)
          weight++;
        else
          age++;
      } else {
        if (number == weight)
          weight--;
        else
          age--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: ReusableCard(
                  onPressed: () {
                    setState(() {
                      selectedGender = Gender.Male;
                    });
                  },
                  colour: selectedGender == Gender.Male
                      ? kActiveCardColor
                      : kInactiveCardColor,
                  cardChild: IconContent(
                      icon: FontAwesomeIcons.mars,
                      text: 'Male',
                      colour: Colors.white),
                ),
              ),
              Expanded(
                child: ReusableCard(
                  onPressed: () {
                    setState(() {
                      selectedGender = Gender.Female;
                    });
                  },
                  colour: selectedGender == Gender.Female
                      ? kActiveCardColor
                      : kInactiveCardColor,
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.venus,
                    text: 'Female',
                    colour: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ReusableCard(
            colour: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'HEIGHT',
                  style: kTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      height.toString(),
                      style: kNumberStyle,
                    ),
                    Text(
                      'cm',
                      style: kTextStyle,
                    )
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Color(0xFF8D8E98),
                    thumbColor: Color(0xFFEB1555),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                    overlayColor: Color(0x29EB1555),
                  ),
                  child: Slider(
                    value: height.toDouble(),
                    min: 120.0,
                    max: 220.0,
                    onChanged: (double newHeight) {
                      setState(() {
                        height = newHeight.round();
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ReusableCard(
                    colour: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WEIGHT',
                          style: kTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kNumberStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                changeNumber(FontAwesomeIcons.minus, weight);
                              },
                            ),
                            SizedBox(width: 10.0),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                changeNumber(FontAwesomeIcons.plus, weight);
                              },
                            )
                          ],
                        ),
                      ],
                    )),
              ),
              Expanded(
                child: ReusableCard(
                    colour: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AGE',
                          style: kTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                changeNumber(FontAwesomeIcons.minus, age);
                              },
                            ),
                            SizedBox(width: 10.0),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                changeNumber(FontAwesomeIcons.plus, age);
                              },
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
        BottomButton(
          buttonTitle: 'CALCULATE',
          onTap: () {
            CalculatorBrain calc =
                CalculatorBrain(height: height, weight: weight);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ResultsPage(
                bmiResult: calc.calculateBMI(),
                resultText: calc.getResult(),
                resultInterpretation: calc.getInterpretation(),
              );
            }));
          },
        )
      ]),
    );
  }
}
