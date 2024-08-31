/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.checkDoneHabitsAndSendNotification =
    functions.pubsub.schedule("0 20 * * *")
        .timeZone("Europe/Istanbul")
        .onRun(async (context) => {
          const usersSnapshot = await admin
              .firestore()
              .collection("users")
              .get();
          const today = new Date();
          const year = today.getFullYear();
          const month = String(today.getMonth() + 1).padStart(2, "0");
          const day = String(today.getDate()).padStart(2, "0");
          const todayId = `${year}${month}${day}`;

          // const batch = admin.firestore().batch();

          const sendNotifications = [];

          usersSnapshot.forEach(async (userDoc) => {
            const userData = userDoc.data();
            const fcmToken = userData.fcmToken;

            if (!fcmToken) {
              return;
            }

            const habitsSnapshot = await admin.firestore()
                .collection(`users/${userDoc.id}/habits`)
                .get();

            let hasDoneToday = false;

            for (const habitDoc of habitsSnapshot.docs) {
              /* eslint-disable max-len */
              const doneHabitDoc = await admin.firestore()
                  .collection(`users/${userDoc.id}/habits/${habitDoc.id}/doneHabits`)
                  .doc(todayId)
                  .get();
              /* eslint-enable max-len */

              if (doneHabitDoc.exists) {
                hasDoneToday = true;
                break;
              }
            }

            if (!hasDoneToday) {
              const message = {
                notification: {
                  title: "Do It!",
                  body: "You have habits to do today!",
                },
                token: fcmToken,
              };

              sendNotifications.push(
                  admin.messaging().send(message)
                      .then((response) => {
                        console.log(`Notification sent: ${response}`);
                      })
                      .catch((error) => {
                        console.error(`Error: ${error}`);
                      }),
              );
            }
          });

          await Promise.all(sendNotifications);
          console.log("All notifications sent");
          return null;
        });
