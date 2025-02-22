import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latihan/login_page.dart';

class HomePage extends StatelessWidget {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.indigo,
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(),
              height: height * 0.20,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.sort,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.transparent,
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/man.png',
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                        Text(
                          'Terakhir di update : 26 juli 2024',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white54,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              height: height * 0.80, // Adjust height as per your requirement
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.3,
                        mainAxisSpacing: 13,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 6, // Assuming you want to display 6 images
                      itemBuilder: (context, index) {
                        // List of image paths
                        List<String> imagePaths = [
                          'assets/images/islamic.png',
                          'assets/images/praying.png',
                          'assets/images/quran.png',
                          'assets/images/time.png',
                          'assets/images/menu.png',
                          'assets/images/haram.png',
                        ];

                        return InkWell(
                          onTap: () {
                            // Handle onTap event if needed
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                )
                              ],
                            ),
                            child: Center(
                              child: Image.asset(
                                imagePaths[
                                    index], // Display image based on index
                                width: 100,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Add spacing between GridView and ElevatedButton
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          },
                        ),
                      ).then((value) {
                        // This code runs after navigating back from LoginPage
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green
                          .shade400, // Background color of the ElevatedButton
                    ),
                    child: Text(
                      'Kembali',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 60), // Add additional spacing if needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
