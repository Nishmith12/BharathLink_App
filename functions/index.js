// functions/index.js

const {onObjectFinalized} = require("firebase-functions/v2/storage");
const {logger} = require("firebase-functions");
const admin = require("firebase-admin");
const path = require("path"); // Import the path module

admin.initializeApp();

exports.analyzeCropImage = onObjectFinalized({cpu: 1}, async (event) => {
  const {bucket, name: filePath, contentType} = event.data;

  if (!contentType || !contentType.startsWith("image/")) {
    logger.log("This is not an image.", {filePath});
    return null;
  }

  if (!filePath || !filePath.startsWith("crop_listings/")) {
    logger.log("Not a crop listing image.", {filePath});
    return null;
  }

  await new Promise((resolve) => setTimeout(resolve, 5000));

  const qualityScore = Math.floor(Math.random() * (98 - 85 + 1)) + 85;
  const defects = ["Slightly high moisture detected", "Minor pest damage", "Uneven size"];
  const randomDefect = defects[Math.floor(Math.random() * defects.length)];
  const suggestion = "Suggest drying for 1-2 extra days for optimal pricing.";

  // --- FIX: A more reliable way to find the document ---
  // Extract the unique file name from the path.
  const fileName = path.basename(filePath);

  const cropsRef = admin.firestore().collection("crops");
  // Query for a document where the imageUrl CONTAINS the unique file name.
  const snapshot = await cropsRef.get();

  const matchingDoc = snapshot.docs.find(doc => {
      const imageUrl = doc.data().imageUrl;
      return imageUrl && imageUrl.includes(fileName);
  });


  if (!matchingDoc) {
    logger.log("No matching crop document found for this image.", {fileName});
    return null;
  }

  logger.log(`Found matching document: ${matchingDoc.id}. Updating with analysis.`);
  return matchingDoc.ref.update({
    qualityAnalysis: {
      score: qualityScore,
      status: qualityScore > 90 ? "Excellent" : "Good",
      defect: randomDefect,
      suggestion: suggestion,
      analyzedAt: admin.firestore.FieldValue.serverTimestamp(),
    },
  });
});
