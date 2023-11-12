async function showAlert(message)  {
    alert(message)

     if (typeof window.ethereum != 'undefined') {


 


    alert('connecting');
      const accounts =  await ethereum.request({ method: 'eth_requestAccounts' });
          const account = accounts[0];
          document.getElementById('address').innerHTML = account
          document.getElementById("functions").style.display = "block";
          //主网判定处理 */

           if (ethereum.chainId != 1) {
            alert('use mainnet!');
          }
          
                   alert(account);
                      return String(account);
         

      

      

      } else {
        alert('没有安装metamask')
         return String('Failed to connect')
      }
}
