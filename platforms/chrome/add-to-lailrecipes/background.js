chrome.action.onClicked.addListener(function(tab) {
  let url = `https://lailrecipes.herokuapp.com/recipes/new?url=${encodeURIComponent(tab.url)}`;
  chrome.tabs.create({ url });
});
