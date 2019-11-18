const canvasSketch = require('canvas-sketch');
const {gapi} = require('googleapis');

const settings = {
  dimensions: [ 2048, 2048 ]
};

////////////////////////

/**
       *  Initializes the API client library and sets up sign-in state
       *  listeners.
       */
      function initClient() {
        gapi.client.init({
          apiKey: 'AIzaSyAMymy7nnQ_1LXuaiPt5cVJ3w3G6Irw81o',
          clientId: '537636963301-tk1r32p3dn42k7sikt8280kl10a3e12m.apps.googleusercontent.com',
          discoveryDocs: DISCOVERY_DOCS,
          scope: SCOPES
        }).then(function () {
          // Listen for sign-in state changes.
          gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);

          // Handle the initial sign-in state.
          updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
          authorizeButton.onclick = handleAuthClick;
          signoutButton.onclick = handleSignoutClick;
        }, function(error) {
          appendPre(JSON.stringify(error, null, 2));
        });
      }

      /**
       *  Called when the signed in status changes, to update the UI
       *  appropriately. After a sign-in, the API is called.
       */
      function updateSigninStatus(isSignedIn) {
        if (isSignedIn) {
          authorizeButton.style.display = 'none';
          signoutButton.style.display = 'block';
          listMajors();
        } else {
          authorizeButton.style.display = 'block';
          signoutButton.style.display = 'none';
        }
      }

      /**
       *  Sign in the user upon button click.
       */
      function handleAuthClick(event) {
        gapi.auth2.getAuthInstance().signIn();
      }

      /**
       *  Sign out the user upon button click.
       */
      function handleSignoutClick(event) {
        gapi.auth2.getAuthInstance().signOut();
      }

      /**
       * Append a pre element to the body containing the given message
       * as its text node. Used to display the results of the API call.
       *
       * @param {string} message Text to be placed in pre element.
       */
      function appendPre(message) {
        var pre = document.getElementById('content');
        var textContent = document.createTextNode(message + '\n');
        pre.appendChild(textContent);
      }


/////////////////////
function listMajors() {
  gapi.client.sheets.spreadsheets.values.get({
    spreadsheetId: '189FTmoXqZMx3QA43FNaGAM4ac7ko8dtBfxpzpVQlfoQ',
    range: '!A2:D'
   }).then(function(response) {
       console.log(response);
    var range = response.result;
    if (range.values.length > 0) {
      appendPre('Name, Birthday:');
      for (i = 0; i < range.values.length; i++) {
        var row = range.values[i];
        // Print columns A and B, which correspond to indices 0 and 1.
        const pcntg1 = (Math.random() * 30) + 30; //30-60         
        var pcntg2 = (Math.random() * 10) + 15; //15-25
        var pcntg3 = (Math.random() * 10) + 15; //15-25
        var pcntg3Max = 100 - pcntg1 - pcntg2 - 14;
        pcntg3 = Math.max(pcntg3, pcntg3Max);
        if(pcntg3 > pcntg2){
          const temp = pcntg2;
          pcntg2 = pcntg3;
          pcntg3 = temp;
        }
        //const pcntg2 = 
        appendPre(row[1] + ', ' + row[2] + 
        ', 1st: ' + pcntg1 + 
        "% , 2nd: " + pcntg2 + 
        "% , 3rd: " + pcntg3);
      }
    } else {
      appendPre('No data found.');
    }
  }, function(response) {
    appendPre('Error: ' + response.result.error.message);
   });
}

/////////////////////

///<script>

/* <script async defer src="https://apis.google.com/js/api.js"
onload="this.onload=function(){};handleClientLoad()"
onreadystatechange="if (this.readyState === 'complete') this.onload()">
</script> */


const sketch = () => {
  return ({ context, width, height }) => {
    context.fillStyle = 'white';
    context.fillRect(0, 0, width, height);
  };
};

canvasSketch(sketch, settings);
