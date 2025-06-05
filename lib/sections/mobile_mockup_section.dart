import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/widgets/animated_text.dart';
import 'dart:async';

class MobileMockupSection extends StatefulWidget {
  const MobileMockupSection({super.key});

  @override
  State<MobileMockupSection> createState() => _MobileMockupSectionState();
}

class _MobileMockupSectionState extends State<MobileMockupSection>
    with SingleTickerProviderStateMixin {
  bool _isAppOpen = false;
  int _currentAppIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Timer _timer;
  late String _currentTime;
  late String _currentDate;

  final List<Map<String, dynamic>> _apps = [
    {
      'name': 'Calculator',
      'icon': Icons.calculate,
      'color': Colors.blue,
      'widget': const CalculatorApp(),
    },
    {
      'name': 'Tic Tac Toe',
      'icon': Icons.grid_3x3,
      'color': Colors.green,
      'widget': const TicTacToeApp(),
    },
    {
      'name': 'Sudoku',
      'icon': Icons.grid_4x4,
      'color': Colors.orange,
      'widget': const SudokuApp(),
    },
    {
      'name': 'Calendar',
      'icon': Icons.calendar_today,
      'color': Colors.red,
      'widget': const CalendarApp(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Initialize time and date
    _updateDateTime();

    // Update time every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateDateTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _updateDateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
      _currentDate =
          '${_getDayName(now.weekday)}, ${_getMonthName(now.month)} ${now.day}';
    });
  }

  String _getDayName(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  void _openApp(int index) {
    setState(() {
      _currentAppIndex = index;
      _isAppOpen = true;
    });
    _animationController.forward();
  }

  void _closeApp() {
    _animationController.reverse().then((_) {
      setState(() {
        _isAppOpen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      color: kBackgroundLight,
      child: Column(
        children: [
          const AnimatedText(
            text: 'Interactive Apps',
            isHeader: true,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Phone Frame
              Container(
                width: 300,
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.grey[800]!, width: 8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Stack(
                    children: [
                      // Home Screen or App Content
                      if (!_isAppOpen)
                        _buildHomeScreen()
                      else
                        SlideTransition(
                          position: _slideAnimation,
                          child: ScaleTransition(
                            scale: _scaleAnimation,
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          _apps[_currentAppIndex]['widget'],
                                          // App Close Button
                                          Positioned(
                                            top: 40,
                                            left: 10,
                                            child: IconButton(
                                              icon: const Icon(Icons.arrow_back,
                                                  color: Colors.white),
                                              onPressed: _closeApp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Navigation Bar
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // Back button
                                          IconButton(
                                            icon: const Icon(
                                              Icons.arrow_back,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                            onPressed: _closeApp,
                                          ),
                                          // Home button
                                          GestureDetector(
                                            onTap: _closeApp,
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.circle,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Recent apps button
                                          IconButton(
                                            icon: const Icon(
                                              Icons.square_outlined,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                            onPressed: _closeApp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      // Status Bar
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 30,
                          color: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 20),
                              Text(
                                _currentTime,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.signal_cellular_alt,
                                      color: Colors.white, size: 12),
                                  SizedBox(width: 5),
                                  Icon(Icons.wifi,
                                      color: Colors.white, size: 12),
                                  SizedBox(width: 5),
                                  Icon(Icons.battery_full,
                                      color: Colors.white, size: 12),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHomeScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue[300]!,
            Colors.blue[500]!,
          ],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          // Time
          Text(
            _currentTime,
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          // Date
          Text(
            _currentDate,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 20),
          // App Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: _apps.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _openApp(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _apps[index]['color'],
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: _apps[index]['color'].withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          _apps[index]['icon'],
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _apps[index]['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Navigation Bar
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Back button
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: () {}, // No action needed on home screen
                ),
                // Home button
                GestureDetector(
                  onTap: () {}, // No action needed on home screen
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                // Recent apps button
                IconButton(
                  icon: const Icon(
                    Icons.square_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: () {}, // No action needed on home screen
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
          size: 20,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 9,
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}

// Calculator App
class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _display = '0';
  String _currentNumber = '';
  String _operation = '';
  double _firstNumber = 0;

  void _onNumberPress(String number) {
    setState(() {
      if (_display == '0') {
        _display = number;
      } else {
        _display += number;
      }
      _currentNumber = _display;
    });
  }

  void _onOperationPress(String operation) {
    setState(() {
      _firstNumber = double.parse(_display);
      _operation = operation;
      _display = '0';
    });
  }

  void _onEqualsPress() {
    setState(() {
      double secondNumber = double.parse(_currentNumber);
      switch (_operation) {
        case '+':
          _display = (_firstNumber + secondNumber).toString();
          break;
        case '-':
          _display = (_firstNumber - secondNumber).toString();
          break;
        case '×':
          _display = (_firstNumber * secondNumber).toString();
          break;
        case '÷':
          _display = (_firstNumber / secondNumber).toString();
          break;
      }
    });
  }

  void _onClearPress() {
    setState(() {
      _display = '0';
      _currentNumber = '';
      _operation = '';
      _firstNumber = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomRight,
            child: Text(
              _display,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _buildButton('C', Colors.red, _onClearPress),
                _buildButton('±', Colors.grey, () {}),
                _buildButton('%', Colors.grey, () {}),
                _buildButton('÷', Colors.orange, () => _onOperationPress('÷')),
                _buildButton('7', Colors.grey[800]!, () => _onNumberPress('7')),
                _buildButton('8', Colors.grey[800]!, () => _onNumberPress('8')),
                _buildButton('9', Colors.grey[800]!, () => _onNumberPress('9')),
                _buildButton('×', Colors.orange, () => _onOperationPress('×')),
                _buildButton('4', Colors.grey[800]!, () => _onNumberPress('4')),
                _buildButton('5', Colors.grey[800]!, () => _onNumberPress('5')),
                _buildButton('6', Colors.grey[800]!, () => _onNumberPress('6')),
                _buildButton('-', Colors.orange, () => _onOperationPress('-')),
                _buildButton('1', Colors.grey[800]!, () => _onNumberPress('1')),
                _buildButton('2', Colors.grey[800]!, () => _onNumberPress('2')),
                _buildButton('3', Colors.grey[800]!, () => _onNumberPress('3')),
                _buildButton('+', Colors.orange, () => _onOperationPress('+')),
                _buildButton('0', Colors.grey[800]!, () => _onNumberPress('0')),
                _buildButton('.', Colors.grey[800]!, () => _onNumberPress('.')),
                _buildButton('=', Colors.orange, _onEqualsPress),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: text == '0' ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: text == '0' ? BorderRadius.circular(35) : null,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// Tic Tac Toe App
class TicTacToeApp extends StatefulWidget {
  const TicTacToeApp({super.key});

  @override
  State<TicTacToeApp> createState() => _TicTacToeAppState();
}

class _TicTacToeAppState extends State<TicTacToeApp> {
  List<String> _board = List.filled(9, '');
  bool _isXTurn = true;
  String _winner = '';

  void _onTap(int index) {
    if (_board[index] == '' && _winner == '') {
      setState(() {
        _board[index] = _isXTurn ? 'X' : 'O';
        _isXTurn = !_isXTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (_board[i] != '' &&
          _board[i] == _board[i + 1] &&
          _board[i] == _board[i + 2]) {
        _winner = _board[i];
        return;
      }
    }
    // Check columns
    for (int i = 0; i < 3; i++) {
      if (_board[i] != '' &&
          _board[i] == _board[i + 3] &&
          _board[i] == _board[i + 6]) {
        _winner = _board[i];
        return;
      }
    }
    // Check diagonals
    if (_board[0] != '' && _board[0] == _board[4] && _board[0] == _board[8]) {
      _winner = _board[0];
      return;
    }
    if (_board[2] != '' && _board[2] == _board[4] && _board[2] == _board[6]) {
      _winner = _board[2];
      return;
    }
    // Check for draw
    if (!_board.contains('')) {
      _winner = 'Draw';
    }
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _isXTurn = true;
      _winner = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            _winner == '' ? 'Tic Tac Toe' : 'Winner: $_winner',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onTap(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _board[index],
                            style: GoogleFonts.poppins(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: _board[index] == 'X'
                                  ? Colors.blue
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: _resetGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Reset Game',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Sudoku App
class SudokuApp extends StatefulWidget {
  const SudokuApp({super.key});

  @override
  State<SudokuApp> createState() => _SudokuAppState();
}

class _SudokuAppState extends State<SudokuApp> {
  List<List<int>> _board = List.generate(9, (_) => List.filled(9, 0));
  List<List<bool>> _isFixed = List.generate(9, (_) => List.filled(9, false));
  int _selectedRow = -1;
  int _selectedCol = -1;

  @override
  void initState() {
    super.initState();
    _generateSudoku();
  }

  void _generateSudoku() {
    // Simple Sudoku generation (you can make this more complex)
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (i < 3 && j < 3) {
          _board[i][j] = (i + j + 1) % 9 + 1;
          _isFixed[i][j] = true;
        }
      }
    }
  }

  void _onCellTap(int row, int col) {
    if (!_isFixed[row][col]) {
      setState(() {
        _selectedRow = row;
        _selectedCol = col;
      });
    }
  }

  void _onNumberPress(int number) {
    if (_selectedRow != -1 &&
        _selectedCol != -1 &&
        !_isFixed[_selectedRow][_selectedCol]) {
      setState(() {
        _board[_selectedRow][_selectedCol] = number;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            'Sudoku',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 9,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                  ),
                  itemCount: 81,
                  itemBuilder: (context, index) {
                    final row = index ~/ 9;
                    final col = index % 9;
                    final isSelected =
                        row == _selectedRow && col == _selectedCol;
                    final isFixed = _isFixed[row][col];
                    final value = _board[row][col];

                    return GestureDetector(
                      onTap: () => _onCellTap(row, col),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.withOpacity(0.2)
                              : (row ~/ 3 + col ~/ 3) % 2 == 0
                                  ? Colors.grey[200]
                                  : Colors.white,
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 0.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            value == 0 ? '' : value.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight:
                                  isFixed ? FontWeight.bold : FontWeight.normal,
                              color: isFixed ? Colors.black : Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Number Pad
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                9,
                (index) => GestureDetector(
                  onTap: () => _onNumberPress(index + 1),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Calendar App
class CalendarApp extends StatefulWidget {
  const CalendarApp({super.key});

  @override
  State<CalendarApp> createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {
  late DateTime _currentDate;
  late String _monthYear;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _updateMonthYear();
  }

  void _updateMonthYear() {
    _monthYear = '${_getMonthName(_currentDate.month)} ${_currentDate.year}';
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the first day of the month
    final firstDayOfMonth = DateTime(_currentDate.year, _currentDate.month, 1);
    // Get the last day of the month
    final lastDayOfMonth =
        DateTime(_currentDate.year, _currentDate.month + 1, 0);
    // Get the day of week for the first day (0 = Sunday, 6 = Saturday)
    final firstWeekday = firstDayOfMonth.weekday % 7;
    // Total number of days in the month
    final daysInMonth = lastDayOfMonth.day;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            _monthYear,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          // Days of week header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                  .map(
                    (day) => SizedBox(
                      width: 30,
                      child: Text(
                        day,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: 42, // 6 rows * 7 days
              itemBuilder: (context, index) {
                // Calculate the day number
                final dayNumber = index - firstWeekday + 1;
                final isCurrentMonth =
                    dayNumber > 0 && dayNumber <= daysInMonth;
                final isToday = isCurrentMonth && dayNumber == _currentDate.day;

                return Container(
                  decoration: BoxDecoration(
                    color: isToday ? Colors.blue : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      isCurrentMonth ? dayNumber.toString() : '',
                      style: TextStyle(
                        color: isToday ? Colors.white : Colors.black,
                        fontWeight:
                            isToday ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
